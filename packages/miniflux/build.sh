NEOTERM_PKG_HOMEPAGE=https://miniflux.app/
NEOTERM_PKG_DESCRIPTION="A minimalist and opinionated feed reader"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.1.0"
NEOTERM_PKG_SRCURL=https://github.com/miniflux/v2/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=64826ccf0b144ef60ecd4155e4ca0d144db73b9e302711577c12a10edc1da3c5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="VERSION=$NEOTERM_PKG_VERSION"

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin miniflux
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man1 miniflux.1
}
