NEOTERM_PKG_HOMEPAGE=http://gnuplot.info/
NEOTERM_PKG_DESCRIPTION="Command-line driven graphing utility"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="Copyright"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="6.0.0"
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/gnuplot/gnuplot/${NEOTERM_PKG_VERSION}/gnuplot-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=635a28f0993f6ab0d1179e072ad39b8139d07f51237f841d93c6c2ff4b1758ec
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib, libandroid-support, libcairo, libgd, libiconv, libx11, pango, readline"
NEOTERM_PKG_BREAKS="gnuplot-x"
NEOTERM_PKG_REPLACES="gnuplot-x"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
--disable-wxwidgets
--without-lua
--without-qt
"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-wxwidgets
--with-x
--without-lua
--with-bitmap-terminals
--without-latex
--without-qt
ac_cv_search_iconv_open=-liconv
"

neoterm_step_host_build() {
	"$NEOTERM_PKG_SRCDIR/configure" \
		${NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -C docs/ gnuplot.gih
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/gnuplot/${NEOTERM_PKG_VERSION:0:3}/

	cp $NEOTERM_PKG_HOSTBUILD_DIR/docs/gnuplot.gih \
	   $NEOTERM_PREFIX/share/gnuplot/${NEOTERM_PKG_VERSION:0:3}/gnuplot.gih
}
