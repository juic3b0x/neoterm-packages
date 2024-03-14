NEOTERM_PKG_HOMEPAGE="https://github.com/epi052/feroxbuster"
NEOTERM_PKG_DESCRIPTION="A fast, simple, recursive content discovery tool written in Rust"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.10.2"
NEOTERM_PKG_SRCURL="https://github.com/epi052/feroxbuster/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=c73d26f21431c5dad77b6910471f768df5b27d5486b276f328f2d370d1c57003
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="openssl"

neoterm_step_post_get_source() {
	sed -i -E '/^openssl\s*=/s/(,\s*)?"vendored"//g' Cargo.toml
}

neoterm_step_pre_configure() {
	rm -f Makefile
}

neoterm_step_post_make_install() {
	# shell completions
	install -Dm644 "$NEOTERM_PKG_SRCDIR/shell_completions/feroxbuster.bash" \
		"$NEOTERM_PREFIX"/share/bash-completion/completions/feroxbuster
	install -Dm644 "$NEOTERM_PKG_SRCDIR/shell_completions/_feroxbuster" \
		"$NEOTERM_PREFIX"/share/zsh/site-functions/_feroxbuster
	install -Dm644 "$NEOTERM_PKG_SRCDIR/shell_completions/feroxbuster.fish" \
		"$NEOTERM_PREFIX"/share/fish/vendor_completions.d/feroxbuster.fish
}
