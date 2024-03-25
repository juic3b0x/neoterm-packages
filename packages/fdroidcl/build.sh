NEOTERM_PKG_HOMEPAGE=https://github.com/mvdan/fdroidcl
NEOTERM_PKG_DESCRIPTION="F-Droid client"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.7.0"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/mvdan/fdroidcl/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=4dbbb2106c23564a19cdde912d3f06cd258f02eccd6382a0532ef64e7e61f2fd
NEOTERM_PKG_DEPENDS="android-tools"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR

	mkdir -p "$GOPATH"/src/mvdan.cc
	cp -a "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/mvdan.cc/fdroidcl
	cd "$GOPATH"/src/mvdan.cc/fdroidcl

	go build .
}

neoterm_step_make_install() {
	install -Dm700 "$NEOTERM_PKG_BUILDDIR"/src/mvdan.cc/fdroidcl/fdroidcl \
		"$NEOTERM_PREFIX"/bin/fdroidcl
}
