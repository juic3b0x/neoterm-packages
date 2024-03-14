NEOTERM_PKG_HOMEPAGE=https://github.com/benhsm/minesweeper
NEOTERM_PKG_DESCRIPTION="A simple terminal-based implementation of Minesweeper"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.3.1"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/benhsm/minesweeper/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=18d33713b0ab1d3ee40741ba712124fc973e8d6cffd6e5d5649c358a0cbf30b2
NEOTERM_PKG_GROUPS="games"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	go build -o minesweeper
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}"/bin minesweeper
}
