NEOTERM_PKG_HOMEPAGE=https://github.com/kak-lsp/kak-lsp
NEOTERM_PKG_DESCRIPTION="Language Server Protocol Client for the Kakoune editor"
NEOTERM_PKG_LICENSE="MIT, Unlicense"
NEOTERM_PKG_MAINTAINER="@finagolfin"
NEOTERM_PKG_VERSION="16.0.0"
NEOTERM_PKG_SRCURL=https://github.com/kak-lsp/kak-lsp/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=85977d86c1a5dce709ca705a26d2913c121f31b58f6f28c8b138264092126a1b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	rm Makefile
}

neoterm_step_post_make_install() {
	rm -rf $NEOTERM_PREFIX/share/kak-lsp
	mkdir -p $NEOTERM_PREFIX/share/kak-lsp/examples
	cp $NEOTERM_PKG_SRCDIR/kak-lsp.toml $NEOTERM_PREFIX/share/kak-lsp/examples
	cp -r $NEOTERM_PKG_SRCDIR/rc $NEOTERM_PREFIX/share/kak-lsp
}
