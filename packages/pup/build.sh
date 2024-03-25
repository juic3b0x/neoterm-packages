NEOTERM_PKG_HOMEPAGE=https://github.com/ericchiang/pup
NEOTERM_PKG_DESCRIPTION="command line tool for processing HTML"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION=0.4.0
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://github.com/ericchiang/pup/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0d546ab78588e07e1601007772d83795495aa329b19bd1c3cde589ddb1c538b0
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	cd "$NEOTERM_PKG_SRCDIR"

	export GOPATH="${NEOTERM_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/ericchiang/"
	cp -a "${NEOTERM_PKG_SRCDIR}" "${GOPATH}/src/github.com/ericchiang/pup"
	cd "${GOPATH}/src/github.com/ericchiang/pup"
	export GO111MODULE=off

	go get -d -v
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin "$GOPATH"/src/github.com/ericchiang/pup/pup
}
