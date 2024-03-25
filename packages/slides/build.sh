NEOTERM_PKG_HOMEPAGE=https://github.com/maaslalani/slides
NEOTERM_PKG_DESCRIPTION="Slides in your terminal"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@neoterm.dev>"
NEOTERM_PKG_VERSION="0.9.0"
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/maaslalani/slides/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=fcce0dbbe767e0b1f0800e4ea934ee9babbfb18ab2ec4b343e3cd6359cd48330
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	cd "$NEOTERM_PKG_SRCDIR"
	make build
}

neoterm_step_make_install() {
	install -Dm700 \
		"$NEOTERM_PKG_SRCDIR"/slides \
		"$NEOTERM_PREFIX"/bin/
}
