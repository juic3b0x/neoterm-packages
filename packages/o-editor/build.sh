NEOTERM_PKG_HOMEPAGE=https://github.com/xyproto/o
NEOTERM_PKG_DESCRIPTION="Small, fast and limited text editor"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="Alexander F. Rødseth <xyproto@archlinux.org>"
NEOTERM_PKG_VERSION="2.65.11"
NEOTERM_PKG_SRCURL=https://github.com/xyproto/o/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=ed0b663a91c084a05e138a1d011931a896e6a312700b984d76385e675646ddbd
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="o"
NEOTERM_PKG_REPLACES="o"

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/xyproto
	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/xyproto/o

	cd "$GOPATH"/src/github.com/xyproto/o/v2
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin \
		"$GOPATH"/src/github.com/xyproto/o/v2/orbiton
	ln -sfT orbiton "$NEOTERM_PREFIX"/bin/o
	install -Dm600 -t "$NEOTERM_PREFIX"/share/man/man1 \
		"$NEOTERM_PKG_SRCDIR"/o.1
}
