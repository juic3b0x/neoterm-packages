NEOTERM_PKG_HOMEPAGE=https://botan.randombit.net/
NEOTERM_PKG_DESCRIPTION="Crypto and TLS for Modern C++"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
# This specific package is for libbotan-3.
NEOTERM_PKG_VERSION="3.2.0"
NEOTERM_PKG_SRCURL=https://botan.randombit.net/releases/Botan-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=049c847835fcf6ef3a9e206b33de05dd38999c325e247482772a5598d9e5ece3
NEOTERM_PKG_DEPENDS="libbz2, libc++, liblzma, libsqlite, zlib"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--cpu=$NEOTERM_ARCH
--os=android
--no-install-python-module
--without-documentation
--with-boost
--with-bzip2
--with-lzma
--with-sqlite3
--with-zlib
--prefix=$NEOTERM_PREFIX
--program-suffix=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1)
"

neoterm_step_pre_configure() {
	CXXFLAGS+=" $CPPFLAGS"
}

neoterm_step_configure() {
	python3 $NEOTERM_PKG_SRCDIR/configure.py \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
}

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/libbotan-3.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
