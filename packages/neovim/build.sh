NEOTERM_PKG_HOMEPAGE=https://neovim.io/
NEOTERM_PKG_DESCRIPTION="Ambitious Vim-fork focused on extensibility and agility (nvim)"
NEOTERM_PKG_LICENSE="Apache-2.0, VIM License"
NEOTERM_PKG_LICENSE_FILE="LICENSE.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.9.5"
NEOTERM_PKG_SRCURL=https://github.com/neovim/neovim/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fe74369fc30a32ec7a086b1013acd0eacd674e7570eb1acc520a66180c9e9719
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="^\d+\.\d+\.\d+$"
NEOTERM_PKG_DEPENDS="libiconv, libuv, luv, libmsgpack, libandroid-support, libvterm (>= 1:0.3-0), libtermkey, libluajit, libunibilium, libtreesitter"
NEOTERM_PKG_HOSTBUILD=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_JEMALLOC=OFF
-DGETTEXT_MSGFMT_EXECUTABLE=$(command -v msgfmt)
-DGETTEXT_MSGMERGE_EXECUTABLE=$(command -v msgmerge)
-DPKG_CONFIG_EXECUTABLE=$(command -v pkg-config)
-DXGETTEXT_PRG=$(command -v xgettext)
-DLUAJIT_INCLUDE_DIR=$NEOTERM_PREFIX/include/luajit-2.1
-DCOMPILE_LUA=OFF
"
NEOTERM_PKG_CONFFILES="share/nvim/sysinit.vim"

neoterm_pkg_auto_update() {
	# Get the latest release tag:
	local tag
	tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}" \
		latest-regex "${NEOTERM_PKG_UPDATE_VERSION_REGEXP}")"
	neoterm_pkg_upgrade_version "$tag"
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

	make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$NEOTERM_PKG_HOSTBUILD_DIR -DUSE_BUNDLED_LUAROCKS=ON" install ||
		(_patch_luv $NEOTERM_PKG_SRCDIR/.deps && make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$NEOTERM_PKG_HOSTBUILD_DIR -DUSE_BUNDLED_LUAROCKS=ON" install)

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
	cat <<-EOF >./postinst
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

	cat <<-EOF >./prerm
		#!$NEOTERM_PREFIX/bin/sh
		if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
			if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
				update-alternatives --remove editor $NEOTERM_PREFIX/bin/nvim
				update-alternatives --remove vi $NEOTERM_PREFIX/bin/nvim
			fi
		fi
	EOF
}
