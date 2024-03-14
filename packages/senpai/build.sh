NEOTERM_PKG_HOMEPAGE=https://git.sr.ht/~taiite/senpai
NEOTERM_PKG_DESCRIPTION="An IRC client that works best with bouncers"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:0.3.0"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://git.sr.ht/~taiite/senpai/archive/v${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=c02f63a7d76ae13ed888fc0de17fa9fd5117dcb3c9edc5670341bf2bf3b88718
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}
