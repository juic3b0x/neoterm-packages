NEOTERM_PKG_HOMEPAGE=https://fishshell.com/
NEOTERM_PKG_DESCRIPTION="The user-friendly command line shell"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.7.0"
NEOTERM_PKG_SRCURL=https://github.com/fish-shell/fish-shell/releases/download/$NEOTERM_PKG_VERSION/fish-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=df1b7378b714f0690b285ed9e4e58afe270ac98dbc9ca5839589c1afcca33ab1
NEOTERM_PKG_AUTO_UPDATE=true
# fish calls 'tput' from ncurses-utils, at least when cancelling (Ctrl+C) a command line.
# man is needed since fish calls apropos during command completion.
NEOTERM_PKG_DEPENDS="libc++, ncurses, libandroid-support, ncurses-utils, man, bc, pcre2, libandroid-spawn"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_DOCS=OFF
"

neoterm_step_pre_configure() {
	CXXFLAGS+=" $CPPFLAGS"
}

neoterm_step_post_make_install() {
	cat >> $NEOTERM_PREFIX/etc/fish/config.fish <<HERE

function __fish_command_not_found_handler --on-event fish_command_not_found
	$NEOTERM_PREFIX/libexec/neoterm/command-not-found \$argv[1]
end
HERE
}
