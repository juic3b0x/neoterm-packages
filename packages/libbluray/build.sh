NEOTERM_PKG_HOMEPAGE=https://code.videolan.org/videolan/libbluray/
NEOTERM_PKG_DESCRIPTION="An open-source library designed for Blu-Ray Discs playback for media players"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.4
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.videolan.org/pub/videolan/libbluray/${NEOTERM_PKG_VERSION}/libbluray-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=478ffd68a0f5dde8ef6ca989b7f035b5a0a22c599142e5cd3ff7b03bbebe5f2b
NEOTERM_PKG_DEPENDS="fontconfig, freetype, libudfread, libxml2"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-bdjava-jar
--disable-optimizations
"

neoterm_step_pre_configure() {
	unset JDK_HOME
}
