NEOTERM_PKG_HOMEPAGE=https://github.com/knqyf263/pet
NEOTERM_PKG_DESCRIPTION="Simple command-line snippet manager"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.7.0"
NEOTERM_PKG_SRCURL=https://github.com/knqyf263/pet/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6bf7e39877683a0022ce46221e9fb5ff8c8fd100aa38f903756faf8cdbb67208
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="fzf"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build -o pet -ldflags="-s -w -X 'github.com/knqyf263/pet/cmd.version=${NEOTERM_PKG_VERSION}'"
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin "$NEOTERM_PKG_SRCDIR"/pet
}
