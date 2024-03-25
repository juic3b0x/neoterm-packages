NEOTERM_PKG_HOMEPAGE=https://github.com/42wim/matterbridge
NEOTERM_PKG_DESCRIPTION="A simple chat bridge"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.26.0"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/42wim/matterbridge/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=00e1bbfe3b32f2feccf9a7f13a6f12b1ce28a5eb04cc7b922b344e3493497425
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_DEPENDS="binutils-cross"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" = arm ]; then
		neoterm_setup_no_integrated_as
	fi

	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build -tags whatsappmulti
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin matterbridge
}
