NEOTERM_PKG_HOMEPAGE=https://github.com/jart/hiptext
NEOTERM_PKG_DESCRIPTION="Turn images into text better than caca/aalib"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.2
NEOTERM_PKG_REVISION=8
NEOTERM_PKG_SRCURL=https://github.com/jart/hiptext/releases/download/$NEOTERM_PKG_VERSION/hiptext-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=7f2217dec8775b445be6745f7bd439c24ce99c4316a9faf657bee7b42bc72e8f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ffmpeg, freetype, gflags, google-glog, libjpeg-turbo, libpng, ncurses"
NEOTERM_PKG_BUILD_DEPENDS="ragel"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	#Font reference on file font.cc --> Patch by font.cc.patch
	#Because of ttf-dejavu is x11 package, the hiptext is not a x11 package.
	install -Dm600 -t "$NEOTERM_PREFIX"/share/hiptext/ \
		"$NEOTERM_PKG_SRCDIR"/DejaVuSansMono.ttf
}
