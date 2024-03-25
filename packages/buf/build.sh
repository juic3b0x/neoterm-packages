NEOTERM_PKG_HOMEPAGE=https://buf.build
NEOTERM_PKG_DESCRIPTION="A new way of working with Protocol Buffers"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.30.0"
NEOTERM_PKG_SRCURL=https://github.com/bufbuild/buf/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a67192bd6fc001a8e764040bf6eced5ffb93fcfa513d546f43a9016d5aae4a5a
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	cd "$NEOTERM_PKG_SRCDIR"
	mkdir -p "${NEOTERM_PKG_BUILDDIR}/src/github.com/bufbuild"
	cp -a "${NEOTERM_PKG_SRCDIR}" "${NEOTERM_PKG_BUILDDIR}/src/github.com/bufbuild/buf"
	cd "${NEOTERM_PKG_BUILDDIR}/src/github.com/bufbuild/buf"

	go mod download 
	go build -ldflags "-s -w" -trimpath ./cmd/buf
}

neoterm_step_make_install() {
	install -Dm700 ${NEOTERM_PKG_BUILDDIR}/src/github.com/bufbuild/buf/buf \
		 $NEOTERM_PREFIX/bin/buf
}
