NEOTERM_PKG_HOMEPAGE=https://sites.google.com/site/gogdownloader/
NEOTERM_PKG_DESCRIPTION="Open source downloader to GOG.com for Linux users using the same API as the official GOGDownloader"
NEOTERM_PKG_LICENSE="WTFPL"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.12"
NEOTERM_PKG_SRCURL=https://github.com/Sude-/lgogdownloader/releases/download/v${NEOTERM_PKG_VERSION}/lgogdownloader-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bf3a16c1b2ff09152f9ac52ea9b52dfc0afae799ed1b370913149cec87154529
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="boost, jsoncpp, libc++, libcurl, libhtmlcxx, libtinyxml2, rhash"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DHELP2MAN=OFF"
