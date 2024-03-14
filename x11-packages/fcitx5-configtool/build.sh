NEOTERM_PKG_HOMEPAGE=https://fcitx-im.org/
NEOTERM_PKG_DESCRIPTION="Configuration tool for Fcitx5"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.1.4"
NEOTERM_PKG_SRCURL=https://github.com/fcitx/fcitx5-configtool/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7ae28a817807da7a102143382503e1fa32732e0475661c68cece47915f238ed8
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="fcitx5, fcitx5-qt, iso-codes, kitemviews, kwidgetsaddons, libc++, libx11, libxkbfile, qt5-qtbase, qt5-qtsvg, qt5-qtx11extras, xkeyboard-config"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_TEST=OFF
-DENABLE_CONFIG_QT=ON
-DENABLE_KCM=OFF
"
