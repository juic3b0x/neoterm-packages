NEOTERM_PKG_HOMEPAGE=https://github.com/zu1k/nali
NEOTERM_PKG_DESCRIPTION="An offline tool for querying IP geographic information and CDN provider"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.1"
NEOTERM_PKG_SRCURL=https://github.com/zu1k/nali/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8918e4c1c720dad1590a42fa04c5fea1ec862148127206e716daa16c1ce3561c
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin nali
}
