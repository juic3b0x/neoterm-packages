NEOTERM_PKG_HOMEPAGE=https://neovim.io
NEOTERM_PKG_DESCRIPTION="Ambitious Vim-fork focused on extensibility and agility (nvim-nightly)"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="Aditya Alok <alok@neoterm.org>"
# Upstream now has version number like "0.8.0-dev-698-ga5920e98f", but actually
# "0.8.0-dev-698-g1ef84547a" < "0.8.0-dev-nightly-10-g1a07044c1", we need to bump
# the epoch of the package version.
NEOTERM_PKG_VERSION="1:0.10.0-dev-122+g95c6e1b74"
NEOTERM_PKG_SRCURL="https://github.com/neovim/neovim/archive/nightly.tar.gz"
NEOTERM_PKG_SHA256=783dfad368dc36e4f7fe26d39ba08ec0b346e7f34cb414f4e05450559d867f21
NEOTERM_PKG_DEPENDS="libiconv, libuv, luv, libmsgpack, libandroid-support, libvterm, libtermkey, libluajit, libunibilium, libtreesitter"
NEOTERM_PKG_HOSTBUILD=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_BUILD_TYPE=RelWithDebInfo
-DENABLE_JEMALLOC=OFF
-DGETTEXT_MSGFMT_EXECUTABLE=$(command -v msgfmt)
-DGETTEXT_MSGMERGE_EXECUTABLE=$(command -v msgmerge)
-DGPERF_PRG=$NEOTERM_PKG_HOSTBUILD_DIR/deps/usr/bin/gperf
-DLUA_PRG=$NEOTERM_PKG_HOSTBUILD_DIR/deps/usr/bin/luajit
-DPKG_CONFIG_EXECUTABLE=$(command -v pkg-config)
-DXGETTEXT_PRG=$(command -v xgettext)
-DLUAJIT_INCLUDE_DIR=$NEOTERM_PREFIX/include/luajit-2.1
-DCOMPILE_LUA=OFF
"
NEOTERM_PKG_CONFFILES="share/nvim/sysinit.vim"
NEOTERM_PKG_CONFLICTS="neovim"

NEOTERM_PKG_AUTO_UPDATE=true

neoterm_pkg_auto_update() {
	# Scrap and parse github release page to get version of nightly build.
	# Neovim just uses 'nightly' tag for release, not version, therefore cannot use github api.
	local curl_response
	curl_response=$(
		curl \
			--silent \
			"https://github.com/neovim/neovim/releases/tag/nightly" \
			--write-out '|%{http_code}'
	) || {
		local http_code="${curl_response##*|}"
		if [[ "${http_code}" != "200" ]]; then
			echo "Error: failed to get latest neovim-nightly tag page."
			echo -e "http code: ${http_code}\ncurl response: ${curl_response}"
			exit 1
		fi
	}

	# this outputs in the following format: "0.8.0-dev-698-ga5920e98f"
	local remote_nvim_version
	remote_nvim_version=$(
		echo "$curl_response" \
			| cut -d"|" -f1 | grep -oP '<pre class="notranslate"><code>NVIM v\K.*'
	)

	if [ -z "$remote_nvim_version" ]; then
		echo "ERROR: No version found in nightly page."
		return 1
	fi

	remote_nvim_version="$(grep -oP '^\d+\.\d+\.\d+-dev-\d+\+g[0-9a-f]+' <<< "$remote_nvim_version" || true)"

	if [ -z "$remote_nvim_version" ]; then
		echo "WARNING: Version in nightly page is not in expected format. Skipping auto-update."
		echo "remote_nvim_version: $remote_nvim_version"
		return 0
	fi

	# since we are using a nightly build, therefore no need to check for version increment/decrement.
	if [ "${NEOTERM_PKG_VERSION#*:}" != "${remote_nvim_version}" ]; then
		neoterm_pkg_upgrade_version "${remote_nvim_version}" --skip-version-check
	else
		echo "INFO: No update available."
	fi
}

_patch_luv() {
	# git submodule update --init deps/lua-compat-5.3 failed
	cp -r $1/build/src/lua-compat-5.3/* $1/build/src/luv/deps/lua-compat-5.3/
	cp -r $1/build/src/luajit/* $1/build/src/luv/deps/luajit/
	cp -r $1/build/src/libuv/* $1/build/src/luv/deps/libuv/
}

neoterm_step_host_build() {
	neoterm_setup_cmake

	NEOTERM_ORIGINAL_CMAKE=$(command -v cmake)
	if [ ! -f "$NEOTERM_ORIGINAL_CMAKE.orig" ]; then
		mv "$NEOTERM_ORIGINAL_CMAKE" "$NEOTERM_ORIGINAL_CMAKE.orig"
	fi
	cp "$NEOTERM_PKG_BUILDER_DIR/custom-bin/cmake" "$NEOTERM_ORIGINAL_CMAKE"
	chmod +x "$NEOTERM_ORIGINAL_CMAKE"
	export NEOTERM_ORIGINAL_CMAKE="$NEOTERM_ORIGINAL_CMAKE.orig"

	mkdir -p $NEOTERM_PKG_HOSTBUILD_DIR/deps
	cd $NEOTERM_PKG_HOSTBUILD_DIR/deps
	cmake $NEOTERM_PKG_SRCDIR/cmake.deps

	make -j 1 \
		|| (_patch_luv $NEOTERM_PKG_HOSTBUILD_DIR/deps && make -j 1)

	cd $NEOTERM_PKG_SRCDIR

	make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$NEOTERM_PKG_HOSTBUILD_DIR -DUSE_BUNDLED_LUAROCKS=ON" install \
		|| (_patch_luv $NEOTERM_PKG_SRCDIR/.deps && make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$NEOTERM_PKG_HOSTBUILD_DIR -DUSE_BUNDLED_LUAROCKS=ON" install)

	make distclean
	rm -Rf build/

	cd $NEOTERM_PKG_HOSTBUILD_DIR
}

neoterm_step_pre_configure() {
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DLUA_MATH_LIBRARY=$NEOTERM_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$NEOTERM_HOST_PLATFORM/$NEOTERM_PKG_API_LEVEL/libm.so"
}

neoterm_step_post_make_install() {
	local _CONFIG_DIR=$NEOTERM_PREFIX/share/nvim
	mkdir -p $_CONFIG_DIR
	cp $NEOTERM_PKG_BUILDER_DIR/sysinit.vim $_CONFIG_DIR/
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!$NEOTERM_PREFIX/bin/sh
		if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
			if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
				update-alternatives --install \
					$NEOTERM_PREFIX/bin/editor editor $NEOTERM_PREFIX/bin/nvim 40
				update-alternatives --install \
					$NEOTERM_PREFIX/bin/vi vi $NEOTERM_PREFIX/bin/nvim 15
			fi
		fi
	EOF

	cat <<- EOF > ./prerm
		#!$NEOTERM_PREFIX/bin/sh
		if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
			if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
				update-alternatives --remove editor $NEOTERM_PREFIX/bin/nvim
				update-alternatives --remove vi $NEOTERM_PREFIX/bin/nvim
			fi
		fi
	EOF
}
