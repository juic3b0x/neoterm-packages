NEOTERM_PKG_HOMEPAGE=https://github.com/makeworld-the-better-one/amfora
NEOTERM_PKG_DESCRIPTION="Aims to be the best looking Gemini client"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.9.2
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/makeworld-the-better-one/amfora/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=81bb4605920955ddbeb0e7236be4f89979ab543fd41b34ea4a4846ac947147e2
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}
