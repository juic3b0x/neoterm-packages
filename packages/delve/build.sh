NEOTERM_PKG_HOMEPAGE=https://github.com/go-delve/delve
NEOTERM_PKG_DESCRIPTION="A debugger for the Go programming language"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION="1.22.1"
NEOTERM_PKG_DEPENDS="golang, git"
NEOTERM_PKG_SRCURL=https://github.com/go-delve/delve/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fe6f0d97c233d4f0f1ed422c11508cc57c14e9e0915f9a258f1912c46824cbfb
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_make() {
	neoterm_setup_golang
	cd $NEOTERM_PKG_SRCDIR

	mkdir -p "$NEOTERM_PKG_BUILDDIR"/src/github.com/go-delve/    
	mkdir -p "$NEOTERM_PREFIX"/share/doc/delve
	cp -a "$NEOTERM_PKG_SRCDIR" "$NEOTERM_PKG_BUILDDIR"/src/github.com/go-delve/delve/
	cd "$NEOTERM_PKG_BUILDDIR"/src/github.com/go-delve/delve/cmd/dlv/
	go get -d -v
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin "$NEOTERM_PKG_BUILDDIR"/src/github.com/go-delve/delve/cmd/dlv/dlv
	cp -a "$NEOTERM_PKG_SRCDIR"/Documentation/* "$NEOTERM_PREFIX"/share/doc/delve
}
