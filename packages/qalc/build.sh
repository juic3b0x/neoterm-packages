NEOTERM_PKG_HOMEPAGE=https://qalculate.github.io/
NEOTERM_PKG_DESCRIPTION="Powerful and easy to use command line calculator"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.0.0"
NEOTERM_PKG_SRCURL=https://github.com/Qalculate/libqalculate/releases/download/v$NEOTERM_PKG_VERSION/libqalculate-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=591598dedbcbd80119de052559873530030b3510bca2b0758f088cfb7dafb2ee
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libcurl, libgmp, libiconv, libmpfr, libxml2, readline"
NEOTERM_PKG_BREAKS="qalc-dev"
NEOTERM_PKG_REPLACES="qalc-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--without-icu"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
