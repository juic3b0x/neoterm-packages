NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/mtpaint/
NEOTERM_PKG_DESCRIPTION="Simple paint program for creating icons and pixel based artwork"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=199472ad6a4ecee6c8583fb5a504a2e99712b4fc
NEOTERM_PKG_VERSION=1:3.50.09
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/wjaguar/mtPaint/archive/${_COMMIT}.zip
NEOTERM_PKG_SHA256=a5bcf9e98959506817cf39aafcf07a0403a4aab405031a46603f0eb7ca80f028
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="atk, freetype, gdk-pixbuf, glib, gtk3, harfbuzz, libandroid-glob, libcairo, libiconv, libjpeg-turbo, libpng, libtiff, libwebp, libx11, littlecms, openjpeg, pango, zlib"
NEOTERM_PKG_RECOMMENDS="gifsicle"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--prefix=$NEOTERM_PREFIX
cflags
gtk3
jpeg
lcms2
man
tiff
"

neoterm_step_post_get_source() {
	local v=$(sed -En 's/^MT_V="([^"]+)".*/\1/p' configure)
	if [ "${v}" != "${NEOTERM_PKG_VERSION#*:}" ]; then
		neoterm_error_exit "Version string '$NEOTERM_PKG_VERSION' does not seem to be correct."
	fi
}

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

neoterm_step_configure() {
	sh $NEOTERM_PKG_SRCDIR/configure ${NEOTERM_PKG_EXTRA_CONFIGURE_ARGS}
}
