NEOTERM_PKG_HOMEPAGE=http://openscad.org/
NEOTERM_PKG_DESCRIPTION="The programmers solid 3D CAD modeller (headless build)"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2021.01
NEOTERM_PKG_SRCURL=https://files.openscad.org/openscad-$NEOTERM_PKG_VERSION.src.tar.gz
NEOTERM_PKG_SHA256=d938c297e7e5f65dbab1461cac472fc60dfeaa4999ea2c19b31a4184f2d70359
NEOTERM_PKG_DEPENDS="boost, double-conversion, fontconfig, freetype, glib, harfbuzz, libc++, libgmp, libmpfr, libxml2, libzip"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers, cgal, eigen"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBoost_USE_STATIC_LIBS=OFF
-DBUILD_SHARED_LIBS=ON
-DBUILD_STATIC_LIBS=OFF
-DNULLGL=ON
"

neoterm_step_make_install () {
	mkdir -p $NEOTERM_PREFIX/share/openscad
	install openscad $NEOTERM_PREFIX/bin/
	cp -r $NEOTERM_PKG_SRCDIR/libraries $NEOTERM_PREFIX/share/openscad/
	cp -r $NEOTERM_PKG_SRCDIR/examples $NEOTERM_PREFIX/share/openscad/
}
