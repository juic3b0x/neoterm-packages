NEOTERM_PKG_HOMEPAGE=https://github.com/rgburke/grv
NEOTERM_PKG_DESCRIPTION="A terminal based interface for viewing Git repositories"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.3.2
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=git+https://github.com/rgburke/grv
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libgit2, ncurses, ncurses-ui-libs, readline"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	export GO111MODULE=off
	export GOPATH=$NEOTERM_PKG_BUILDDIR/_go
	mkdir -p $GOPATH
	ln -sfT $NEOTERM_PKG_SRCDIR/cmd/grv/vendor $GOPATH/src
}

neoterm_step_make() {
	local _DATE=$(date -u '+%Y-%m-%d %H:%M:%S %Z')
	go build -ldflags "-X \"main.version=$NEOTERM_PKG_VERSION\" -X \"main.buildDateTime=$_DATE\"" \
		./cmd/grv
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin grv
}
