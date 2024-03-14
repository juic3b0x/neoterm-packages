NEOTERM_PKG_HOMEPAGE=https://github.com/nxtrace/Ntrace-V1
NEOTERM_PKG_DESCRIPTION="An open source visual routing tool that pursues light weight"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.2.8"
NEOTERM_PKG_SRCURL=https://github.com/nxtrace/Ntrace-V1/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3984f137d3a306c3db7e0c14c7fb41ef303c3162921e46fc9bff196f9c4ba7f8
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build -o nexttrace
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin nexttrace
}
