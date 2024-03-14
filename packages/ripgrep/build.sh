NEOTERM_PKG_HOMEPAGE=https://github.com/BurntSushi/ripgrep
NEOTERM_PKG_DESCRIPTION="Search tool like grep and The Silver Searcher"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="14.1.0"
NEOTERM_PKG_SRCURL=https://github.com/BurntSushi/ripgrep/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=33c6169596a6bbfdc81415910008f26e0809422fda2d849562637996553b2ab6
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="pcre2"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--features pcre2"

neoterm_step_post_make_install() {
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/man/man1/rg.1"

	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/bash-completion/completions/rg.bash"
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/zsh/site-functions/_rg"
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/fish/vendor_completions.d/rg.fish"
}

neoterm_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		rg --generate complete-bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/rg.bash
		rg --generate complete-zsh > ${NEOTERM_PREFIX}/share/zsh/site-functions/_rg
		rg --generate complete-fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/rg.fish
		rg --generate man > ${NEOTERM_PREFIX}/share/man/man1/rg.1
	EOF
}
