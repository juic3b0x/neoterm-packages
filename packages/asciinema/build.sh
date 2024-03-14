NEOTERM_PKG_HOMEPAGE=https://asciinema.org/
NEOTERM_PKG_DESCRIPTION="Record and share your terminal sessions, the right way"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.4.0"
NEOTERM_PKG_SRCURL=https://github.com/asciinema/asciinema/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b0e05f0b5ae7ae4e7186c6bd824e6d670203bb24f1c89ee52fc8fae7254e6091
NEOTERM_PKG_AUTO_UPDATE=true
# ncurses-utils for tput which asciinema uses:
NEOTERM_PKG_DEPENDS="python, ncurses-utils"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_HAS_DEBUG=false
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"

neoterm_step_make() {
	return
}
