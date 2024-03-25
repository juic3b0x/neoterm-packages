NEOTERM_PKG_HOMEPAGE=https://tuxpaint.org/
NEOTERM_PKG_DESCRIPTION="A free, award-winning drawing program for children ages 3 to 12"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.9.32"
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/tuxpaint/tuxpaint-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=09cce22241481dc1360fc4bc5d4da1d31815d7a2563b9e9fa217a672ba974bf2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="fribidi, libandroid-wordexp, libcairo, libimagequant, libpaper, libpng, librsvg, sdl2, sdl2-gfx, sdl2-image, sdl2-mixer, sdl2-pango, sdl2-ttf, tuxpaint-data, zlib"
NEOTERM_PKG_BUILD_DEPENDS="glib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix

	# Need imagemagick that can handle SVG format.
	local IMAGEMAGICK_BUILD_SH=$NEOTERM_SCRIPTDIR/packages/imagemagick/build.sh
	local IMAGEMAGICK_SRCURL=$(bash -c ". $IMAGEMAGICK_BUILD_SH; echo \$NEOTERM_PKG_SRCURL")
	local IMAGEMAGICK_SHA256=$(bash -c ". $IMAGEMAGICK_BUILD_SH; echo \$NEOTERM_PKG_SHA256")
	local IMAGEMAGICK_TARFILE=$NEOTERM_PKG_CACHEDIR/$(basename $IMAGEMAGICK_SRCURL)
	neoterm_download $IMAGEMAGICK_SRCURL $IMAGEMAGICK_TARFILE $IMAGEMAGICK_SHA256
	mkdir -p imagemagick
	cd imagemagick
	tar xf $IMAGEMAGICK_TARFILE --strip-components=1
	./configure --prefix=$_PREFIX_FOR_BUILD \
		--with-jpeg \
		--with-png \
		--with-rsvg
	make -j $NEOTERM_MAKE_PROCESSES
	make install
}

neoterm_step_pre_configure() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix
	export PATH=$_PREFIX_FOR_BUILD/bin:$PATH

	CPPFLAGS+=" -U__ANDROID__"
	LDFLAGS+=" -landroid-wordexp"
}

neoterm_step_post_configure() {
	# https://github.com/juic3b0x/neoterm-packages/issues/12458
	mkdir -p trans
}
