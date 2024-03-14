NEOTERM_PKG_HOMEPAGE=https://icecast.org
NEOTERM_PKG_DESCRIPTION="Icecast is a streaming media (audio/video) server"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.4.4
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://downloads.xiph.org/releases/icecast/icecast-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=49b5979f9f614140b6a38046154203ee28218d8fc549888596a683ad604e4d44
NEOTERM_PKG_DEPENDS="libcurl, libgnutls, libogg, libvorbis, libxml2, libxslt, media-types, openssl"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	perl -p -i -e "s#/etc/mime.types#$NEOTERM_PREFIX/etc/mime.types#" $NEOTERM_PKG_SRCDIR/src/cfgfile.c
}
