NEOTERM_PKG_HOMEPAGE=https://github.com/fcitx/xcb-imdkit
NEOTERM_PKG_DESCRIPTION="An implementation of xim protocol in xcb"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.0.7"
NEOTERM_PKG_SRCURL=https://github.com/fcitx/xcb-imdkit/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c904dae07f9c971b21ef43b7ae9a2018a1b3ceda0ea5c44efbdb61a7c8b161f8
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libxcb, xcb-util"
NEOTERM_PKG_BUILD_DEPENDS="extra-cmake-modules, uthash, xcb-util-keysyms"
