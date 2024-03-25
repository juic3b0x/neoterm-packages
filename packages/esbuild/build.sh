NEOTERM_PKG_HOMEPAGE=https://esbuild.github.io/
NEOTERM_PKG_DESCRIPTION="An extremely fast JavaScript bundler"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.20.1"
NEOTERM_PKG_SRCURL=https://github.com/evanw/esbuild/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9a64617be3fe4a461da4fb965a44a3db01df8f08db015a0c6804c6c61893391c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build ./cmd/esbuild
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin esbuild
}
