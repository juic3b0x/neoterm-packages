NEOTERM_PKG_HOMEPAGE=https://fly.io
NEOTERM_PKG_DESCRIPTION="Command line tools for fly.io services"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@neoterm.dev>"
NEOTERM_PKG_VERSION="0.2.17"
NEOTERM_PKG_SRCURL=https://github.com/superfly/flyctl/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=32ba1debe0bccfef716d33dad888807f4ee9a6ccad5a92eb94dfd5d9159efd52
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_BLACKLISTED_ARCHES="i686, arm"


neoterm_step_post_get_source() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_SRCDIR/go
	export GOOS="android"
	go get
	chmod +w $GOPATH -R
}

neoterm_step_make() {
	export GOPATH=$NEOTERM_PKG_SRCDIR/go
	go build -o bin/flyctl
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin "$NEOTERM_PKG_SRCDIR/bin/flyctl"
}
