NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X.Org font utilities"
# Licenses: MIT, BSD 2-Clause, UCD
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.4.1"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/font/font-util-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=5c9f64123c194b150fee89049991687386e6ff36ef2af7b80ba53efaf368cc95
NEOTERM_PKG_AUTO_UPDATE=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-mapdir=${NEOTERM_PREFIX}/share/fonts/util
--with-fontrootdir=${NEOTERM_PREFIX}/share/fonts
"
