NEOTERM_PKG_HOMEPAGE=https://vale.sh
NEOTERM_PKG_DESCRIPTION="A syntax-aware linter for prose built with speed and extensibility in mind"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.3.0"
NEOTERM_PKG_SRCURL=https://github.com/errata-ai/vale/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bfa2229e53180e58daee75f0206da9c69943c5c07f35465d023deeabb916b23b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	cd "$NEOTERM_PKG_SRCDIR"/cmd/vale
	go build -o vale -ldflags="-s -w -X 'main.version=${NEOTERM_PKG_VERSION}'"
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin "$NEOTERM_PKG_SRCDIR"/cmd/vale/vale
}
