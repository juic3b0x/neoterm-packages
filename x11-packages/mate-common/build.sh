NEOTERM_PKG_HOMEPAGE=https://mate-desktop.org/
NEOTERM_PKG_DESCRIPTION="Common scripts and macros to develop with MATE"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.28.0"
NEOTERM_PKG_SRCURL=https://github.com/mate-desktop/mate-common/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7100ecd60a9b5f398b9c3508eb17bca657bb748a74fc9f277b1e5ba1e022b701
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_pre_configure() {
	autoreconf -fi
}
