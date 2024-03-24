TERMUX_PKG_HOMEPAGE=https://github.com/BurntSushi/ripgrep
TERMUX_PKG_DESCRIPTION="Search tool like grep and The Silver Searcher"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION="14.1.0"
TERMUX_PKG_SRCURL=https://github.com/BurntSushi/ripgrep/archive/$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=33c6169596a6bbfdc81415910008f26e0809422fda2d849562637996553b2ab6
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="pcre2"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--features pcre2"

termux_step_post_make_install() {
	install -Dm644 /dev/null "${TERMUX_PREFIX}/share/man/man1/rg.1"

	install -Dm644 /dev/null "${TERMUX_PREFIX}/share/bash-completion/completions/rg.bash"
	install -Dm644 /dev/null "${TERMUX_PREFIX}/share/zsh/site-functions/_rg"
	install -Dm644 /dev/null "${TERMUX_PREFIX}/share/fish/vendor_completions.d/rg.fish"
}

termux_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${TERMUX_PREFIX}/bin/sh
		rg --generate complete-bash > ${TERMUX_PREFIX}/share/bash-completion/completions/rg.bash
		rg --generate complete-zsh > ${TERMUX_PREFIX}/share/zsh/site-functions/_rg
		rg --generate complete-fish > ${TERMUX_PREFIX}/share/fish/vendor_completions.d/rg.fish
		rg --generate man > ${TERMUX_PREFIX}/share/man/man1/rg.1
	EOF
}
