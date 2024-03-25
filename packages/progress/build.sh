NEOTERM_PKG_HOMEPAGE=https://github.com/Xfennec/progress
NEOTERM_PKG_DESCRIPTION="Linux tool to show progress for cp, mv, dd and more"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.17"
NEOTERM_PKG_SRCURL=https://github.com/Xfennec/progress/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=ee9538fce98895dcf0d108087d3ee2e13f5c08ed94c983f0218a7a3d153b725d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libandroid-wordexp, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-wordexp"
}
