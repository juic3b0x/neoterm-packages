NEOTERM_PKG_HOMEPAGE=https://github.com/devnev/libxdg-basedir
NEOTERM_PKG_DESCRIPTION="An implementation of the XDG Base Directory specifications"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.3
NEOTERM_PKG_SRCURL=https://github.com/devnev/libxdg-basedir/archive/libxdg-basedir-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ff30c60161f7043df4dcc6e7cdea8e064e382aa06c73dcc3d1885c7d2c77451d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology

neoterm_step_pre_configure() {
	autoreconf -fi
}
