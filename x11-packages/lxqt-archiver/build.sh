NEOTERM_PKG_HOMEPAGE=https://lxqt.github.io
NEOTERM_PKG_DESCRIPTION="A simple & lightweight Qt file archiver"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="0.9.1"
NEOTERM_PKG_SRCURL="https://github.com/lxqt/lxqt-archiver/releases/download/${NEOTERM_PKG_VERSION}/lxqt-archiver-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=32aa42add94f84dc4bbdc288ff5f13770951a7e96071ffa70034e939f9d7ce39
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtx11extras, libfm-qt, glib, json-glib"
NEOTERM_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_AUTO_UPDATE=true
