NEOTERM_PKG_HOMEPAGE=https://botan.randombit.net/
NEOTERM_PKG_DESCRIPTION="Crypto and TLS for Modern C++"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
# This specific package is for libbotan-2.
NEOTERM_PKG_VERSION=2.19.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://botan.randombit.net/releases/Botan-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=dae047f399c5a47f087db5d3d9d9e8f11ae4985d14c928d71da1aff801802d55
NEOTERM_PKG_DEPENDS="libbz2, libc++, liblzma, libsqlite, zlib"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--cpu=$NEOTERM_ARCH
--os=linux
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
	local _GUARD_FILE="lib/libbotan-2.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
