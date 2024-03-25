NEOTERM_PKG_HOMEPAGE=https://github.com/dundee/gdu
NEOTERM_PKG_DESCRIPTION="Fast disk usage analyzer with console interface written in Go"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.27.0"
NEOTERM_PKG_SRCURL=https://github.com/dundee/gdu/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=ea337207adea2860445f8a4b50a05045fd0a9055236e91a3e70c3462fc9e199f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang

	make build
	make gdu.1
}

neoterm_step_make_install() {
	install -D dist/gdu -t $NEOTERM_PREFIX/bin
	install -Dm644 gdu.1 -t $NEOTERM_PREFIX/share/man/man1
}
