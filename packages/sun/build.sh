NEOTERM_PKG_HOMEPAGE=https://stand-up-notes.org
NEOTERM_PKG_DESCRIPTION="A very simple note taking cli app"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/basbossink/sun/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f0c90b8796caa66662dd82790449ca844708e20b39f7e81ef7f1cbce211d1412
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "${NEOTERM_PKG_BUILDDIR}"/src/github.com/basbossink/
	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/basbossink/sun

	cd "$GOPATH"/src/github.com/basbossink/sun
	go build -ldflags "-s -w -X main.Version=${NEOTERM_PKG_VERSION}" .
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin \
		${NEOTERM_PKG_BUILDDIR}/src/github.com/basbossink/sun/sun
}
