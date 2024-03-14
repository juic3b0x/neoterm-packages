NEOTERM_PKG_HOMEPAGE="https://github.com/sumneko/lua-language-server"
NEOTERM_PKG_DESCRIPTION="Sumneko Lua Language Server coded in Lua"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Aditya Alok <alok@neoterm.org>"
NEOTERM_PKG_VERSION="3.7.4"
NEOTERM_PKG_GIT_BRANCH="${NEOTERM_PKG_VERSION}"
NEOTERM_PKG_SRCURL="git+https://github.com/sumneko/lua-language-server"
NEOTERM_PKG_DEPENDS="libandroid-spawn, libc++"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

_patch_on_device() {
	if [ "${NEOTERM_ON_DEVICE_BUILD}" = true ]; then
		(
			cd "${NEOTERM_PKG_SRCDIR}"
			patch --silent -p1 < "${NEOTERM_PKG_BUILDER_DIR}"/android.diff
		)
	fi
}

neoterm_step_host_build() {
	_patch_on_device
	neoterm_setup_ninja

	mkdir 3rd
	cp -a "${NEOTERM_PKG_SRCDIR}"/3rd/luamake 3rd/

	cd 3rd/luamake
	./compile/install.sh
}

neoterm_step_make() {
	CFLAGS+=" -DBEE_ENABLE_FILESYSTEM"     # without this, it tries to link against its own filesystem lib and fails.
	CFLAGS+=" -Wno-unknown-warning-option" # for -Wno-maybe-uninitialized argument.

	sed \
		-e "s%\@FLAGS\@%${CFLAGS} ${CPPFLAGS}%g" \
		-e "s%\@LDFLAGS\@%${LDFLAGS}%g" \
		"${NEOTERM_PKG_BUILDER_DIR}"/make.lua.diff | patch --silent -p1

	"${NEOTERM_PKG_HOSTBUILD_DIR}"/3rd/luamake/luamake \
		-cc "${CC}" \
		-hostos "android"
}

neoterm_step_make_install() {
	local datadir="${NEOTERM_PREFIX}/share/${NEOTERM_PKG_NAME}"

	cat > "${NEOTERM_PREFIX}/bin/${NEOTERM_PKG_NAME}" <<- EOF
		#!${NEOTERM_PREFIX}/bin/bash

		# After action of neoterm-elf-cleaner lua-language-server's binary is unable to
		# determine its version, so provide it manually.
		if [ "\$1" = "--version" ]; then
			echo "${NEOTERM_PKG_NAME}: ${NEOTERM_PKG_VERSION}"
		else
			TMPPATH=\$(mktemp -d "${NEOTERM_PREFIX}/tmp/${NEOTERM_PKG_NAME}.XXXX")

			exec ${datadir}/bin/${NEOTERM_PKG_NAME} \\
				--logpath="\${TMPPATH}/log" \\
				--metapath="\${TMPPATH}/meta" \\
				"\${@}"
		fi

	EOF

	chmod 0700 "${NEOTERM_PREFIX}/bin/${NEOTERM_PKG_NAME}"

	install -Dm700 -t "${datadir}"/bin ./bin/"${NEOTERM_PKG_NAME}"
	install -Dm600 -t "${datadir}" ./{main,debugger}.lua
	install -Dm600 -t "${datadir}"/bin ./bin/main.lua

	cp -r ./script ./meta ./locale "${datadir}"
}
