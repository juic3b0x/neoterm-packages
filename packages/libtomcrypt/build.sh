NEOTERM_PKG_HOMEPAGE=https://www.libtom.net/LibTomCrypt/
NEOTERM_PKG_DESCRIPTION="A fairly comprehensive, modular and portable cryptographic toolkit"
NEOTERM_PKG_LICENSE="Public Domain, WTFPL"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.18.2
NEOTERM_PKG_SRCURL=https://github.com/libtom/libtomcrypt/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d870fad1e31cb787c85161a8894abb9d7283c2a654a9d3d4c6d45a1eba59952c
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
-f makefile.shared
PREFIX=$NEOTERM_PREFIX
"

neoterm_step_pre_configure() {
	local libtooldir=$NEOTERM_PKG_TMPDIR/_libtool
	mkdir -p $libtooldir
	pushd $libtooldir
	cat > configure.ac <<-EOF
		AC_INIT
		LT_INIT
		AC_OUTPUT
	EOF
	touch install-sh
	cp "$NEOTERM_SCRIPTDIR/scripts/config.sub" ./
	cp "$NEOTERM_SCRIPTDIR/scripts/config.guess" ./
	autoreconf -fi
	./configure --host=$NEOTERM_HOST_PLATFORM
	popd
	export LIBTOOL=$libtooldir/libtool
}
