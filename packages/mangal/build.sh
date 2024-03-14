NEOTERM_PKG_HOMEPAGE=https://github.com/metafates/mangal
NEOTERM_PKG_DESCRIPTION="Cli manga downloader"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.0.6"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=git+https://github.com/metafates/mangal
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy 
}

neoterm_step_make() {
	go build -o mangal
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin mangal
}
