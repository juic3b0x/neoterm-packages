NEOTERM_PKG_HOMEPAGE=https://www.dmulholl.com/dev/mp3cat.html
NEOTERM_PKG_DESCRIPTION="A command line utility for joining MP3 files."
NEOTERM_PKG_LICENSE="Unlicense"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.2.2
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/dmulholl/mp3cat/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=457e680e5b05e8a5a50a8b557372e23bf797026f43253efdff14b8137f214470
NEOTERM_PKG_CONFLICTS="mp3cat"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	go build
}

neoterm_step_make_install() {
	install -Dm700 mp3cat $NEOTERM_PREFIX/bin/
}
