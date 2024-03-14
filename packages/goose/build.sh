NEOTERM_PKG_HOMEPAGE=https://pressly.github.io/goose
NEOTERM_PKG_DESCRIPTION="A database migration tool. Supports SQL migrations and Go functions."
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.19.1"
NEOTERM_PKG_SRCURL="https://github.com/pressly/goose/archive/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=3beae1149bca2ff9b2958b97a0246536304d3f6769dccbc418031c292ab4392a
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang
	go mod tidy
}

neoterm_step_make() {
	go build -o goose ./cmd/goose
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin goose
}

neoterm_step_install_license() {
	install -Dm600 -t "${NEOTERM_PREFIX}/share/doc/${NEOTERM_PKG_NAME}" \
		"${NEOTERM_PKG_SRCDIR}/LICENSE"
}
