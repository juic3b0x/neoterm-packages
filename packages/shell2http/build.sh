NEOTERM_PKG_HOMEPAGE=https://github.com/msoap/shell2http
NEOTERM_PKG_DESCRIPTION="Executing shell commands via HTTP server"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION="1.16.0"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/msoap/shell2http/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=90aa95c7b7bdb068b5b4a44e3e6782cda6b8417efbd0551383fb4f102e04584c
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	cd "$NEOTERM_PKG_SRCDIR"

	export GOPATH="${NEOTERM_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/msoap/"
	cp -a "${NEOTERM_PKG_SRCDIR}" "${GOPATH}/src/github.com/msoap/shell2http"
	cd "${GOPATH}/src/github.com/msoap/shell2http"
	go get -d -v
	go build -ldflags "-X 'main.version=$NEOTERM_PKG_VERSION'"
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin "$GOPATH"/src/github.com/msoap/shell2http/shell2http
}
