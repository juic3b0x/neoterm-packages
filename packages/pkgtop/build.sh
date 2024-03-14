NEOTERM_PKG_HOMEPAGE=https://github.com/orhun/pkgtop
NEOTERM_PKG_DESCRIPTION="Interactive package manager and resource monitor"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.5.1"
NEOTERM_PKG_SRCURL=https://github.com/orhun/pkgtop/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3d8f1cd812fd2243fbf749ab03201bb86b9967cefd5d58cea456cdfcccfd416e
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build -o pkgtop ./cmd
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin pkgtop
}
