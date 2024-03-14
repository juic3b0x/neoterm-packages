NEOTERM_PKG_HOMEPAGE=https://github.com/elves/elvish
NEOTERM_PKG_DESCRIPTION="A friendly and expressive Unix shell"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.19.2
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/elves/elvish/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=ef8032507c74c84369d49b098afcf1da65701aa071be9ee762f8bc456576ac94

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/elves
	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/elves/elvish

	cd "$GOPATH"/src/github.com/elves/elvish/cmd/elvish
	go build
}

neoterm_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/elves/elvish/cmd/elvish/elvish \
		"$NEOTERM_PREFIX"/bin/elvish
}
