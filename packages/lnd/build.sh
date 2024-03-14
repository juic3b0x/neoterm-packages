NEOTERM_PKG_HOMEPAGE=https://github.com/lightningnetwork/lnd
NEOTERM_PKG_DESCRIPTION="Lightning Network Daemon"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.17.0-beta"
NEOTERM_PKG_SRCURL=(https://github.com/lightningnetwork/lnd/archive/v${NEOTERM_PKG_VERSION}.tar.gz
                   https://github.com/lightningnetwork/lnd/releases/download/v${NEOTERM_PKG_VERSION}/vendor.tar.gz)
NEOTERM_PKG_SHA256=(9aeb1e37e7ffb8726ac8f34c546455305f50fa1a011669462e567740bde26cec
                   4b465f4b334b3516b1150dfde6be6fa78c53938af6e253a456c234f1799a4512)
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="bitcoin"
NEOTERM_PKG_SERVICE_SCRIPT=("lnd" 'exec lnd 2>&1')
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang
	GO111MODULE=on go build -tags linux -v -mod=vendor -ldflags "-X github.com/lightningnetwork/lnd/build.Commit=v$NEOTERM_PKG_VERSION" ./cmd/lnd
	GO111MODULE=on go build -tags linux -v -mod=vendor -ldflags "-X github.com/lightningnetwork/lnd/build.Commit=v$NEOTERM_PKG_VERSION" ./cmd/lncli
}

neoterm_step_make_install() {
	install -Dm700 lnd lncli "$NEOTERM_PREFIX"/bin/
}
