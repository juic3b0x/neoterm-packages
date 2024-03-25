NEOTERM_PKG_HOMEPAGE=https://github.com/txthinking/brook
NEOTERM_PKG_DESCRIPTION="A cross-platform strong encryption and not detectable proxy. Zero-Configuration."
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION="20240404"
NEOTERM_PKG_SRCURL=https://github.com/txthinking/brook/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6eda9a348f9c3555a1c27711e81c0982ea9999bf2878e73cf2eaaee90e8cc2e7
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	cd "$NEOTERM_PKG_SRCDIR"

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/txthinking
	mkdir -p "$NEOTERM_PREFIX"/share/doc/brook
	cp -a "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/txthinking/brook
	cd "$GOPATH"/src/github.com/txthinking/brook/cli/brook
	go get -d -v
	go build -o brook 
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin "$GOPATH"/src/github.com/txthinking/brook/cli/brook/brook
	cp -r "$NEOTERM_PKG_SRCDIR"/docs/* "$NEOTERM_PREFIX"/share/doc/brook
}
