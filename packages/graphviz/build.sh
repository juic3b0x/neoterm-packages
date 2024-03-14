NEOTERM_PKG_HOMEPAGE=https://www.graphviz.org/
NEOTERM_PKG_DESCRIPTION="Rich set of graph drawing tools"
NEOTERM_PKG_LICENSE="EPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="10.0.1"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://gitlab.com/graphviz/graphviz/-/archive/$NEOTERM_PKG_VERSION/graphviz-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=28f452ef1cb12288c8758a62f8c3fcfefdb91b251f7aae61d0d703f851bde931
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="fontconfig, freetype, gdk-pixbuf, glib, harfbuzz, libandroid-glob, libc++, libcairo, libexpat, libgd, libgts, libltdl, librsvg, libwebp, pango, zlib"
NEOTERM_PKG_BREAKS="graphviz-dev"
NEOTERM_PKG_REPLACES="graphviz-dev"
NEOTERM_PKG_BUILD_DEPENDS="libtool"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-guile=no
--enable-java=no
--enable-lua=no
--enable-ocaml=no
--enable-perl=no
--enable-php=no
--enable-python=no
--enable-r=no
--enable-ruby=no
--enable-sharp=no
--enable-swig=no
--enable-tcl=no
--with-ann=no
--with-expatlibdir=$NEOTERM_PREFIX/lib
--with-ltdl-include=$NEOTERM_PREFIX/include
--with-ltdl-lib=$NEOTERM_PREFIX/lib
--with-pangocairo=yes
--with-pic
--with-poppler=no
--with-x=no
"
NEOTERM_PKG_FORCE_CMAKE=false
NEOTERM_PKG_RM_AFTER_INSTALL="bin/*-config share/man/man1/*-config.1"

neoterm_step_pre_configure() {
	./autogen.sh NOCONFIG
	export HOSTCC="gcc"

	LDFLAGS+=" -lm -landroid-glob"
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
	LDFLAGS+=" -Wl,-rpath=$NEOTERM_PREFIX/lib/graphviz"
}

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "dot -c" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
