NEOTERM_PKG_HOMEPAGE=https://wxmaxima-developers.github.io/wxmaxima/
NEOTERM_PKG_DESCRIPTION="A document based interface for the computer algebra system Maxima"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="24.02.2"
NEOTERM_PKG_SRCURL=https://github.com/wxMaxima-developers/wxmaxima/archive/refs/tags/Version-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ad0b3b7dca4cc554cd29bdf8261f4dce75a01df5898f7efde2c03d539fd074a9
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/.*-//'
NEOTERM_PKG_DEPENDS="libc++, maxima, wxwidgets"
NEOTERM_PKG_BLACKLISTED_ARCHES="i686, x86_64"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DwxWidgets_CONFIG_EXECUTABLE=$NEOTERM_PREFIX/bin/wx-config
-DWXM_INCLUDE_FONTS=OFF
-DWXM_UNIT_TESTS=OFF
"
