NEOTERM_PKG_HOMEPAGE=https://pmt.sourceforge.io/pngcrush/
NEOTERM_PKG_DESCRIPTION="Recompresses png files"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.8.13
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/pmt/pngcrush-${NEOTERM_PKG_VERSION}-nolib.tar.xz
NEOTERM_PKG_SHA256=3b4eac8c5c69fe0894ad63534acedf6375b420f7038f7fc003346dd352618350
NEOTERM_PKG_DEPENDS="libpng, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="-e"

neoterm_step_pre_configure() {
	export LD="$CC"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin pngcrush
}
