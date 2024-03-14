NEOTERM_PKG_HOMEPAGE=https://github.com/been-jamming/rubiks_cube
NEOTERM_PKG_DESCRIPTION="A rubik's cube that runs in your terminal"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2
NEOTERM_PKG_SRCURL=git+https://github.com/been-jamming/rubiks_cube
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_GROUPS="games"

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin rubiks_cube
}
