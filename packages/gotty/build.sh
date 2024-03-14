NEOTERM_PKG_HOMEPAGE=https://github.com/sorenisanerd/gotty
NEOTERM_PKG_DESCRIPTION="Share your terminal as a web application"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.5.0"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/sorenisanerd/gotty/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=98a5fb9eddefc4bc4d402ad159d274a3876ee2b23cb8940ebeea328b705454a7
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/yudai
	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/yudai/gotty

	cd "$GOPATH"/src/github.com/yudai/gotty
	go mod init || go mod download
	#go mod tidy
	go build
}

neoterm_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/yudai/gotty/gotty \
		"$NEOTERM_PREFIX"/bin/
}
