NEOTERM_PKG_HOMEPAGE=https://github.com/Yawning/obfs4
NEOTERM_PKG_DESCRIPTION="A pluggable transport plugin for Tor"
NEOTERM_PKG_LICENSE="BSD 2-Clause, BSD 3-Clause, GPL-3.0"
NEOTERM_PKG_LICENSE_FILE="LICENSE, LICENSE-GPL3.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.0.14
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/Yawning/obfs4/archive/obfs4proxy-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=a4b7520e732b0f168832f6f2fdf1be57f3e2cce0612e743d3f6b51341a740903
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_BUILD_IN_SRC=true

## obfs4proxy is a pluggable transport plugin for Tor, so
## marking "tor" package as dependency.
NEOTERM_PKG_DEPENDS="tor"

neoterm_step_make() {
	neoterm_setup_golang
	cd "$NEOTERM_PKG_SRCDIR"/obfs4proxy
	go get -d ./...
	go build .
}

neoterm_step_post_make_install() {
	cd "$NEOTERM_PKG_SRCDIR"/obfs4proxy
	install -Dm700 obfs4proxy "${NEOTERM_PREFIX}"/bin/
}
