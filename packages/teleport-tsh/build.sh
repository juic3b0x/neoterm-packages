NEOTERM_PKG_HOMEPAGE=https://github.com/gravitational/teleport
NEOTERM_PKG_DESCRIPTION="Secure Access for Developers that doesn't get in the way"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="15.1.3"
NEOTERM_PKG_SRCURL=https://github.com/gravitational/teleport/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=1b69be7f6edf233873897234d6a08d31cbe0c6035399fb01e3449bd6617131d6
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_CACHEDIR/go
	export BUILDDIR=$NEOTERM_PKG_SRCDIR/cmd

	make $BUILDDIR/tsh
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin $BUILDDIR/tsh
}
