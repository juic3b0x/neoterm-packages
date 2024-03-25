NEOTERM_PKG_HOMEPAGE=https://trzsz.github.io/
NEOTERM_PKG_DESCRIPTION="A simple file transfer tools, similar to lrzsz ( rz / sz )"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.1.7"
NEOTERM_PKG_SRCURL=https://github.com/trzsz/trzsz-go/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ad9f47591d1b2cd6c76e44cf0bcac55906bdff9305d38ad1040bb77529ee3781
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
BIN_DST=$NEOTERM_PREFIX/bin
"

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}
