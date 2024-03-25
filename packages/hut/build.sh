NEOTERM_PKG_HOMEPAGE=https://git.sr.ht/~emersion/hut
NEOTERM_PKG_DESCRIPTION="A CLI tool for sr.ht"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.4.0"
NEOTERM_PKG_SRCURL=https://git.sr.ht/~emersion/hut/refs/download/v${NEOTERM_PKG_VERSION}/hut-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=866c02f89e2597355dd10a445b3fbec826fbb47657bcdc6014d50084f23d88ee
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}
