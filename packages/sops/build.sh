NEOTERM_PKG_HOMEPAGE=https://github.com/mozilla/sops
NEOTERM_PKG_DESCRIPTION="Simple and flexible tool for managing secrets"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="Philipp Schmitt @pschmitt"
NEOTERM_PKG_VERSION="3.8.1"
NEOTERM_PKG_SRCURL="https://github.com/mozilla/sops/archive/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=5ca70fb4f96797d09012c705a5bb935835896de7bcd063b98d498912b0e645a0
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make_install() {
	neoterm_setup_golang

	export GOPATH="${NEOTERM_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/go.mozilla.org"
	cp -a "${NEOTERM_PKG_SRCDIR}" "${GOPATH}/src/go.mozilla.org/sops"
	cd "${GOPATH}/src/go.mozilla.org/sops" || return 9
	go get -d -v
	make install

	install -Dm700 "${GOPATH}/bin/"*/sops "${NEOTERM_PREFIX}/bin/sops"
}
