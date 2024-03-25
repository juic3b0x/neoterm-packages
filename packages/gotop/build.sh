NEOTERM_PKG_HOMEPAGE=https://github.com/xxxserxxx/gotop
NEOTERM_PKG_DESCRIPTION="A terminal based graphical activity monitor inspired by gtop and vtop"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@medzikuser"
NEOTERM_PKG_VERSION="4.2.0"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/xxxserxxx/gotop/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e9d9041903acb6bd3ffe94e0a02e69eea53f1128274da1bfe00fe44331ccceb1
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make_install() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR

	cd $NEOTERM_PKG_SRCDIR

	go build -o gotop \
	    -ldflags "-X main.Version=v${NEOTERM_PKG_VERSION} -X main.BuildDate=$(date +%Y%m%dT%H%M%S)" \
	    ./cmd/gotop

	install -Dm700 -t $NEOTERM_PREFIX/bin ./gotop
}
