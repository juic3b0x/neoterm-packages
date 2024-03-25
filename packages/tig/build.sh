NEOTERM_PKG_HOMEPAGE=https://jonas.github.io/tig/
NEOTERM_PKG_DESCRIPTION="Ncurses-based text-mode interface for git"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.5.8"
NEOTERM_PKG_SRCURL=https://github.com/jonas/tig/releases/download/tig-$NEOTERM_PKG_VERSION/tig-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=b70e0a42aed74a4a3990ccfe35262305917175e3164330c0889bd70580406391
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="libiconv, ncurses, git, libandroid-support"

neoterm_step_post_make_install() {
	make -j 1 install-doc
}
