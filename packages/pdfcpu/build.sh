NEOTERM_PKG_HOMEPAGE="https://pdfcpu.io"
NEOTERM_PKG_DESCRIPTION="A PDF processor written in Go"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.7.0"
NEOTERM_PKG_SRCURL="https://github.com/pdfcpu/pdfcpu/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=e36b1b03ff77fc2b9aa7ab4becfd2e0db271da0d5c56f6eb9b9ac844a04a00c1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang
	cd "${NEOTERM_PKG_SRCDIR}/cmd/pdfcpu"
	go build
}

neoterm_step_make_install() {
	install -Dm700 "${NEOTERM_PKG_SRCDIR}/cmd/pdfcpu/pdfcpu" \
		"$NEOTERM_PREFIX/bin/"
}
