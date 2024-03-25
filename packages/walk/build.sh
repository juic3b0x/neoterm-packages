NEOTERM_PKG_HOMEPAGE=https://github.com/antonmedv/walk
NEOTERM_PKG_DESCRIPTION="A terminal file manager"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.7.0"
NEOTERM_PKG_SRCURL=https://github.com/antonmedv/walk/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b657523d637727cfa408040e9816f45ae868c5192fb3962c32a0edab9d9b00dd
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

# Package was previously named as "llama".
NEOTERM_PKG_BREAKS="llama (<< 1.4.0-2)"
NEOTERM_PKG_REPLACES="llama (<< 1.4.0-2)"

neoterm_step_make() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin walk
}
