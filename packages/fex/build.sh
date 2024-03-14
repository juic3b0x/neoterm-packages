NEOTERM_PKG_HOMEPAGE=https://fex-emu.com/
NEOTERM_PKG_DESCRIPTION="Fast x86 emulation frontend"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2312.1
NEOTERM_PKG_SRCURL=git+https://github.com/FEX-Emu/FEX
NEOTERM_PKG_GIT_BRANCH=FEX-${NEOTERM_PKG_VERSION}
NEOTERM_PKG_DEPENDS="libandroid-shmem, libc++"
NEOTERM_PKG_BUILD_DEPENDS="gdb"
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686, x86_64"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTS=OFF
-DENABLE_ASSERTIONS=ON
-DENABLE_GDB_SYMBOLS=ON
-DENABLE_JEMALLOC=OFF
-DENABLE_JEMALLOC_GLIBC_ALLOC=OFF
-DENABLE_LTO=OFF
-DENABLE_OFFLINE_TELEMETRY=OFF
-DENABLE_NEOTERM_BUILD=ON
-DHAS_CLANG_PRESERVE_ALL=OFF
-DTUNE_ARCH=armv8-a
-DTUNE_CPU=generic
"

neoterm_pkg_auto_update() {
	local latest_tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}")"
	[[ -z "${latest_tag}" ]] && neoterm_error_exit "ERROR: Unable to get tag from ${NEOTERM_PKG_SRCURL}"
	neoterm_pkg_upgrade_version "${latest_tag#FEX-}"
}

neoterm_step_pre_configure() {
	find "${NEOTERM_PKG_SRCDIR}" -name '*.h' -o -name '*.c' -o -name '*.cpp' | \
		xargs -P"${NEOTERM_MAKE_PROCESSES}" -n1 \
		sed \
			-e 's:"/data/local/tmp:"'${NEOTERM_PREFIX}'/tmp:g' \
			-e 's:"/tmp:"'${NEOTERM_PREFIX}'/tmp:g' \
			-i
}
