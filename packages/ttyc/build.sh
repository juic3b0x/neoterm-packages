NEOTERM_PKG_HOMEPAGE=https://github.com/Depau/ttyc
NEOTERM_PKG_DESCRIPTION="ttyd protocol client"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.4"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/Depau/ttyc/archive/refs/tags/ttyc-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=375e2b27335ed3db13aee6d4525548148b8579cdbe34ed4d971d4e3cdff0f173
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy 
}

neoterm_step_make() {
	go build -v ./cmd/ttyc
	cd $NEOTERM_PKG_SRCDIR/cmd/ttyc
	go build -o ttyc
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin cmd/ttyc/ttyc
}
