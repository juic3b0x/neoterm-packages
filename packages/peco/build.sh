NEOTERM_PKG_HOMEPAGE=https://github.com/peco/peco
NEOTERM_PKG_DESCRIPTION="Simplistic interactive filtering tool"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.5.11"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/peco/peco/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8e32c8af533e03795f27feb4ee134960611d2fc0266528b1c512a6f1f065b164
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	cd "$NEOTERM_PKG_SRCDIR"/cmd/peco
	go build -o peco
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin "$NEOTERM_PKG_SRCDIR"/cmd/peco/peco
}
