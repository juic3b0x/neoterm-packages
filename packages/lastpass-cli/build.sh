NEOTERM_PKG_HOMEPAGE=https://lastpass.com/
NEOTERM_PKG_DESCRIPTION="LastPass command line interface tool"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.7"
NEOTERM_PKG_SRCURL=https://github.com/lastpass/lastpass-cli/archive/v$NEOTERM_PKG_VERSION/lastpass-cli-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=3fb1373fc05d568599da7657fcff801cbaa704254f00bb8e13d4510cb236be90
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libcurl, libxml2, openssl, pinentry"
NEOTERM_PKG_SUGGESTS="neoterm-api"

neoterm_step_post_make_install() {
	ninja install-doc

	install -Dm600 "$NEOTERM_PKG_SRCDIR"/contrib/lpass_zsh_completion \
		"$NEOTERM_PREFIX"/share/zsh/site-functions/_lpass

	install -Dm600 "$NEOTERM_PKG_SRCDIR"/contrib/completions-lpass.fish \
		"$NEOTERM_PREFIX"/share/fish/vendor_completions.d/lpass.fish
}
