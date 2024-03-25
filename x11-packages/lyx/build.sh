NEOTERM_PKG_HOMEPAGE=http://www.lyx.org
NEOTERM_PKG_DESCRIPTION="WYSIWYM (What You See Is What You Mean) Document Processor"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="2.3.7p1"
NEOTERM_PKG_SRCURL="https://ftp.lip6.fr/pub/lyx/stable/${NEOTERM_PKG_VERSION%.*}.x/lyx-${NEOTERM_PKG_VERSION/p/-}.tar.xz"
NEOTERM_PKG_SHA256=39be8864fb86b34e88310e70fb80e5e9e296601f0856cf161aa094171718d8ed
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/\./p/3; s/-/p/'
NEOTERM_PKG_DEPENDS="ghostscript, hunspell, imagemagick, libandroid-execinfo, libc++, libxcb, lyx-data, qt5-qtbase, qt5-qtsvg, qt5-qtx11extras, texlive-bin, zlib"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers, qt5-qtbase-cross-tools"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-build-type=rel
--enable-qt5
--without-included-boost
--without-aspell
--with-hunspell
"
NEOTERM_PKG_RM_AFTER_INSTALL="share/lyx/examples"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"

	# This is to allow the build script find the `moc` on cross-build host
	export PATH="${NEOTERM_PREFIX}/opt/qt/cross/bin:${PATH}"
}
