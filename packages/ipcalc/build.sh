NEOTERM_PKG_HOMEPAGE=http://jodies.de/ipcalc
NEOTERM_PKG_DESCRIPTION="Calculates IP broadcast, network, Cisco wildcard mask, and host ranges"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_DEPENDS="perl"
NEOTERM_PKG_VERSION=0.51
NEOTERM_PKG_SRCURL=https://github.com/kjokjo/ipcalc/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a4dbfaeb7511b81830793ab9936bae9d7b1b561ad33e29106faaaf97ba1c117e
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make_install() {
	cp $NEOTERM_PKG_SRCDIR/ipcalc $NEOTERM_PREFIX/bin/
}

