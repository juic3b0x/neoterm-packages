NEOTERM_PKG_HOMEPAGE=https://github.com/schachmat/wego
NEOTERM_PKG_DESCRIPTION="weather app for the terminal"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.2"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="https://github.com/schachmat/wego/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=e7a6d40cb44f4408aedceebbed5854b3b992936cc762df6b76f5a9dca7909321
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build -o wego
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}"/bin wego
}
