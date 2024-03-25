NEOTERM_PKG_HOMEPAGE=https://maunium.net/go/gomuks/
NEOTERM_PKG_DESCRIPTION="A terminal Matrix client written in Go"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.3.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/tulir/gomuks/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0710a63cc3ec9a4f525510497ba64aa94170498eb536411d089871f336d99ab4
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libolm, resolv-conf"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin gomuks
}
