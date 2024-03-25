NEOTERM_PKG_HOMEPAGE="https://github.com/exercism/cli/"
NEOTERM_PKG_DESCRIPTION="A Go based command line tool for exercism.io"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.3.0"
NEOTERM_PKG_SRCURL="https://github.com/exercism/cli/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=65f960c23a2c423cd8dfa2d8fcc1a083c3d5bc483717c96b5c71d3549fbc0fb7
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR
	cd $NEOTERM_PKG_SRCDIR/exercism
	go build
}

neoterm_step_post_make_install() {
	install -Dm700 "$NEOTERM_PKG_SRCDIR/exercism/exercism" \
		"$NEOTERM_PREFIX/bin/exercism"

	# shell completions
	install -Dm644 "$NEOTERM_PKG_SRCDIR/shell/exercism_completion.bash" \
		"$NEOTERM_PREFIX"/share/bash-completion/completions/exercism
	install -Dm644 "$NEOTERM_PKG_SRCDIR/shell/exercism_completion.zsh" \
		"$NEOTERM_PREFIX"/share/zsh/site-functions/_exercism
	install -Dm644 "$NEOTERM_PKG_SRCDIR/shell/exercism.fish" \
		"$NEOTERM_PREFIX"/share/fish/vendor_completions.d/exercism.fish
}
