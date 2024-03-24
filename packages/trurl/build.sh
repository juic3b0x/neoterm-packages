TERMUX_PKG_HOMEPAGE="https://curl.se/trurl/"
TERMUX_PKG_DESCRIPTION="trurl is a command line tool that parses and manipulates URLs"
TERMUX_PKG_LICENSE="curl"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION="0.10"
TERMUX_PKG_SRCURL="https://github.com/curl/trurl/archive/trurl-$TERMUX_PKG_VERSION.tar.gz"
TERMUX_PKG_SHA256="e54ee05a1a39f2547fbb39225f9cf5e2608eeaf07ad3f7dbff0a069d060d3c46"
TERMUX_PKG_DEPENDS="libcurl"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_TAG_TYPE="newest-tag"
TERMUX_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+"
