NEOTERM_PKG_HOMEPAGE=https://github.com/TheLocehiliosan/yadm
NEOTERM_PKG_DESCRIPTION="Yet Another Dotfiles Manager"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.2.2"
NEOTERM_PKG_SRCURL=https://github.com/TheLocehiliosan/yadm/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=c5fb508748995ce4c08a21d8bcda686ad680116ccf00a5318bbccf147f4c33ad
NEOTERM_PKG_DEPENDS="git"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_make() {
	# Do not try to run 'make' as it causes a build failure.
	return
}

neoterm_step_make_install() {
	install -Dm700 "$NEOTERM_PKG_SRCDIR"/yadm "$NEOTERM_PREFIX"/bin/
	install -Dm600 "$NEOTERM_PKG_SRCDIR"/yadm.1 "$NEOTERM_PREFIX"/share/man/man1/
	install -Dm600 "$NEOTERM_PKG_SRCDIR"/completion/bash/yadm \
		"$NEOTERM_PREFIX"/share/bash-completion/completions/yadm
	install -Dm600 "$NEOTERM_PKG_SRCDIR"/completion/zsh/_yadm \
		"$NEOTERM_PREFIX"/share/zsh/site-functions/_yadm
	install -Dm600 "$NEOTERM_PKG_SRCDIR"/completion/fish/yadm.fish \
		"$NEOTERM_PREFIX"/share/fish/vendor_completions.d/yadm.fish
}
