NEOTERM_PKG_HOMEPAGE=https://subtitleripper.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="DVD subtitle ripper for Linux"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_VERSION=0.3-4
NEOTERM_PKG_VERSION=${_VERSION//-/.}
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/subtitleripper/subtitleripper-${_VERSION}.tgz
NEOTERM_PKG_SHA256=8af6c2ebe55361900871c731ea1098b1a03efa723cd29ee1d471435bd21f3ac4
NEOTERM_PKG_DEPENDS="libpng, netpbm, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DHAVE_GETLINE"
	CFLAGS+=" $CPPFLAGS"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin \
		srttool subtitle2pgm subtitle2vobsub vobsub2pgm
}
