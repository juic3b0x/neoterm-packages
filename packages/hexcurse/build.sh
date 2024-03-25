NEOTERM_PKG_HOMEPAGE=https://github.com/LonnyGomes/hexcurse
NEOTERM_PKG_DESCRIPTION="Console hexeditor"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.60.0
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/LonnyGomes/hexcurse/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f6919e4a824ee354f003f0c42e4c4cef98a93aa7e3aa449caedd13f9a2db5530
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ncurses"

neoterm_step_pre_configure() {
	export CFLAGS+=" -fcommon"
}
