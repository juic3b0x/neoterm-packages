NEOTERM_PKG_HOMEPAGE=https://www.aptly.info
NEOTERM_PKG_DESCRIPTION="A Swiss Army knife for Debian repository management"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/aptly-dev/aptly/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=07e18ce606feb8c86a1f79f7f5dd724079ac27196faa61a2cefa5b599bbb5bb1
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR

	mkdir -p "$GOPATH"/src/github.com/aptly-dev/
	cp -a "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/aptly-dev/aptly
	cd "$GOPATH"/src/github.com/aptly-dev/aptly

	go mod tidy
	go mod vendor
	make install VERSION=$NEOTERM_PKG_VERSION
}

neoterm_step_make_install() {
	install -Dm700 \
		"$GOPATH"/bin/${GOOS}_${GOARCH}/aptly \
		"$NEOTERM_PREFIX"/bin/aptly

	install -Dm600 \
		"$NEOTERM_PKG_SRCDIR"/man/aptly.1 \
		"$NEOTERM_PREFIX"/share/man/man1/aptly.1
}
