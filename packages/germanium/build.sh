NEOTERM_PKG_HOMEPAGE=https://github.com/matsuyoshi30/germanium
NEOTERM_PKG_DESCRIPTION="Generate image from source code"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.2.3"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/matsuyoshi30/germanium/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=69c818f06bbd7ea562afb5ed38b24fc2e9e9a447d5668d995314da5203e72de3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_SRCDIR/go
	go get -d ./cmd/germanium
	chmod +w $GOPATH -R
}

neoterm_step_make() {
	export GOPATH=$NEOTERM_PKG_SRCDIR/go
	go build -o germanium -v ./cmd/germanium
}
 
neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin germanium
}
