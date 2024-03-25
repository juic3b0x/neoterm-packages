NEOTERM_PKG_HOMEPAGE=https://www.libtom.net/LibTomMath/
NEOTERM_PKG_DESCRIPTION="A free open source portable number theoretic multiple-precision integer library"
NEOTERM_PKG_LICENSE="Unlicense"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.2.1"
NEOTERM_PKG_SRCURL=https://github.com/libtom/libtommath/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=068adaf5155d28d4ac976eb95ea0df1ecb362f20d777287154c22a24fdb35faa
NEOTERM_PKG_AUTO_UPDATE=true
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
