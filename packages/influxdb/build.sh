NEOTERM_PKG_HOMEPAGE=https://www.influxdata.com/
NEOTERM_PKG_DESCRIPTION="An open source time series database with no external dependencies"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
# It cannot be simply updated to the 2.0 series, for which the build system is
# pretty much different from that for 1.x.
_GIT_BRANCH=1.8
NEOTERM_PKG_VERSION=${_GIT_BRANCH}.10
NEOTERM_PKG_REVISION=3
_COMMIT=688e697c51fd5353725da078555adbeff0363d01
NEOTERM_PKG_SRCURL=https://github.com/influxdata/influxdb/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4f53c61f548bab7cb805af0d02586263d9a348dc18baf90efb142b029e2e7097
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_BUILD_IN_SRC=true
_GO_LDFLAGS="
-X main.version=${NEOTERM_PKG_VERSION}
-X main.branch=${_GIT_BRANCH}
-X main.commit=${_COMMIT}
"

neoterm_step_pre_configure() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR/_go
	mkdir -p $GOPATH
	go mod tidy
}

neoterm_step_make() {
	go install -ldflags="${_GO_LDFLAGS}" ./...
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin $GOPATH/bin/*/influx*
}
