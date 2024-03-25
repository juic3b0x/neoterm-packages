NEOTERM_PKG_HOMEPAGE=https://github.com/ameshkov/dnslookup
NEOTERM_PKG_DESCRIPTION="Simple command line utility to make DNS lookups. Supports all known DNS protocols: plain DNS, DoH, DoT, DoQ, DNSCrypt."
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="kay9925@outlook.com"
NEOTERM_PKG_VERSION=1.10.0
NEOTERM_PKG_SRCURL="https://github.com/ameshkov/dnslookup/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=6001fa5b54ba3a1b29f68eed4d12b026a1b716b1578342621f398fd4d569d199
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_GO_USE_OLDER=false

neoterm_step_make() {
	neoterm_setup_golang

	export CGO_ENABLED=1

	go build -ldflags "-X main.VersionString=v${NEOTERM_PKG_VERSION}" -o "${NEOTERM_PKG_NAME}"
}

neoterm_step_make_install() {
	install -Dm700 ${NEOTERM_PKG_NAME} ${NEOTERM_PREFIX}/bin
}
