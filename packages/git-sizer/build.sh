NEOTERM_PKG_HOMEPAGE=https://github.com/github/git-sizer
NEOTERM_PKG_DESCRIPTION="Compute various size metrics for a Git repository"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@neoterm.dev>"
NEOTERM_PKG_VERSION=1.5.0
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/github/git-sizer/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=07a5ac5f30401a17d164a6be8d52d3d474ee9c3fb7f60fd83a617af9f7e902bb
NEOTERM_PKG_DEPENDS="git"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_CACHEDIR/go
	make
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin bin/git-sizer
}
