NEOTERM_PKG_HOMEPAGE=https://github.com/gopasspw/gopass
NEOTERM_PKG_DESCRIPTION="The slightly more awesome standard unix password manager for teams"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.15.11"
NEOTERM_PKG_SRCURL=https://github.com/gopasspw/gopass/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=f85610a4f114125bd21e1100d6a2970c7ab76f09a7e094aa6be378018979eb56
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="git, gnupg"
NEOTERM_PKG_SUGGESTS="neoterm-api, openssh"

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR

	mkdir -p ./src
	mkdir -p ./src/github.com/gopasspw
	ln -sf "$NEOTERM_PKG_SRCDIR" ./src/github.com/gopasspw/gopass

	rm -f ./src/github.com/gopasspw/gopass/gopass
	make -C ./src/github.com/gopasspw/gopass build CLIPHELPERS="-X github.com/gopasspw/gopass/pkg/clipboard.Helpers=neoterm-api'"
	install -Dm700 \
		./src/github.com/gopasspw/gopass/gopass \
		"$NEOTERM_PREFIX"/bin/gopass
}

neoterm_step_post_make_install() {
	cd "$NEOTERM_PKG_SRCDIR"
	install -Dm600 gopass.1 -t "$NEOTERM_PREFIX/share/man/man1"
	install -Dm600 bash.completion "$NEOTERM_PREFIX/share/bash-completion/completions/gopass"
	install -Dm600 zsh.completion "$NEOTERM_PREFIX/share/zsh/site-functions/_gopass"
	install -Dm600 fish.completion "$NEOTERM_PREFIX/share/fish/vendor_completions.d/gopass.fish"
	install -Dm600 {README,CHANGELOG,ARCHITECTURE}.md -t "$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME"
	cd ./docs
	rm -f logo*.*
	cp --parents -r * -t "$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME"
}
