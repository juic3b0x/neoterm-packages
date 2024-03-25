NEOTERM_PKG_HOMEPAGE=https://github.com/gsamokovarov/jump
NEOTERM_PKG_DESCRIPTION="Jump helps you navigate in shell faster by learning your habits"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.51.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/gsamokovarov/jump/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ce297cada71e1dca33cd7759e55b28518d2bf317cdced1f3b3f79f40fa1958b5

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR
	cd $NEOTERM_PKG_SRCDIR
	go build .
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}"/bin \
		"${NEOTERM_PKG_SRCDIR}"/jump
}
