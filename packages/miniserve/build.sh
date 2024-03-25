NEOTERM_PKG_HOMEPAGE=https://github.com/svenstaro/miniserve
NEOTERM_PKG_DESCRIPTION="Tool to serve files and dirs over HTTP"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.26.0"
NEOTERM_PKG_SRCURL=https://github.com/svenstaro/miniserve/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=5ac3e7220c0c86c23af46326cf88e4d0dc9eb296ca201c47c4c3f01d607edf63
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust

	rm -f Makefile
}

neoterm_step_post_make_install() {
	# shell completions
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/bash-completion/completions/miniserve
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/zsh/site-functions/_miniserve
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/fish/vendor_completions.d/miniserve.fish

	# manpage
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/man/man1/miniserve.1
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh

	miniserve --print-completions bash \
		> "$NEOTERM_PREFIX"/share/bash-completion/completions/miniserve
	miniserve --print-completions zsh \
		> "$NEOTERM_PREFIX"/share/zsh/site-functions/_miniserve
	miniserve --print-completions fish \
		> "$NEOTERM_PREFIX"/share/fish/vendor_completions.d/miniserve.fish
	miniserve --print-manpage \
		> "$NEOTERM_PREFIX"/share/man/man1/miniserve.1

	# Warn user on default behaviour of miniserve.
	echo
	echo "WARNING: miniserve follows symlinks in selected directory by default. Consider aliasing it with '--no-symlinks' for safety."
	echo "See: https://github.com/svenstaro/miniserve/issues/498"
	echo
	EOF
}
