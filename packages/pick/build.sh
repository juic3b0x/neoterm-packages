NEOTERM_PKG_HOMEPAGE=https://github.com/calleerlandsson/pick
NEOTERM_PKG_DESCRIPTION="Utility to choose one option from a set of choices with fuzzy search functionality"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.0.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/calleerlandsson/pick/releases/download/v${NEOTERM_PKG_VERSION}/pick-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=de768fd566fd4c7f7b630144c8120b779a61a8cd35898f0db42ba8af5131edca
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	export MANDIR=$NEOTERM_PREFIX/share/man
}
