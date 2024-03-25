NEOTERM_PKG_HOMEPAGE=https://drobilla.net/software/suil.html
NEOTERM_PKG_DESCRIPTION="A library for loading and wrapping LV2 plugin UIs"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.10.20"
NEOTERM_PKG_SRCURL=https://download.drobilla.net/suil-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=334a3ed3e73d5e17ff400b3db9801f63809155b0faa8b1b9046f9dd3ffef934e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="lv2"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dgtk2=disabled
-Dgtk3=disabled
-Dqt5=disabled
-Dx11=disabled
-Ddocs=disabled
"
