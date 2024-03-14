NEOTERM_PKG_HOMEPAGE=https://common-lisp.net/project/ecl/
NEOTERM_PKG_DESCRIPTION="ECL (Embeddable Common Lisp) is an interpreter of the Common Lisp language"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="23.9.9"
NEOTERM_PKG_SRCURL=https://common-lisp.net/project/ecl/static/files/release/ecl-${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=c51bdab4ca6c1173dd3fe9cfe9727bcefb97bb0a3d6434b627ca6bdaeb33f880
NEOTERM_PKG_DEPENDS="libandroid-support, libgmp, libgc, libffi"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_BLACKLISTED_ARCHES="i686, x86_64"
NEOTERM_PKG_HAS_DEBUG=false

# See https://gitlab.com/embeddable-common-lisp/ecl/-/blob/develop/INSTALL
# for upstream cross build guide.

# ECL needs itself during build, so we need to build it for the host first.
neoterm_step_host_build() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix

	local srcdir=$NEOTERM_PKG_SRCDIR/src
	mkdir $_PREFIX_FOR_BUILD
	autoreconf -fi $srcdir/gmp
	$srcdir/configure ABI=${NEOTERM_ARCH_BITS} \
		CFLAGS=-m${NEOTERM_ARCH_BITS} LDFLAGS=-m${NEOTERM_ARCH_BITS} \
		--prefix=$_PREFIX_FOR_BUILD --srcdir=$srcdir --disable-c99complex
	make
	make install
}

neoterm_step_pre_configure() {
	local srcdir=$NEOTERM_PKG_SRCDIR/src
	autoreconf -fi $srcdir
}

neoterm_step_configure() {
	# Copy cross_config for target architecture.
	case $NEOTERM_ARCH in
		aarch64) crossconfig=android-arm64 ;;
		arm)     crossconfig=android-arm ;;
		*)       neoterm_error_exit "Unsupported arch: $NEOTERM_ARCH" ;;
	esac
	crossconfig="$NEOTERM_PKG_SRCDIR/src/util/$crossconfig.cross_config"
	export ECL_TO_RUN=$NEOTERM_PKG_HOSTBUILD_DIR/prefix/bin/ecl

	local srcdir=$NEOTERM_PKG_SRCDIR/src
	$srcdir/configure \
		--srcdir=$srcdir \
		--prefix=$NEOTERM_PREFIX \
		--host=$NEOTERM_HOST_PLATFORM \
		--build=$NEOTERM_BUILD_TUPLE \
		--with-cross-config=$crossconfig \
		--disable-c99complex \
		--enable-gmp=system \
		--enable-boehm=system
}
