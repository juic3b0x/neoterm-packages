NEOTERM_PKG_HOMEPAGE=https://ohse.de/uwe/software/lrzsz.html
NEOTERM_PKG_DESCRIPTION="Tools for zmodem/xmodem/ymodem file transfer"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.12.21-rc1
_COMMIT=8cb2a6a29f6345f84d5e8248e2d3376166ab844f
NEOTERM_PKG_SRCURL=https://github.com/UweOhse/lrzsz/archive/$_COMMIT.tar.gz
NEOTERM_PKG_SHA256=56f79c3eb8f6b140693667802d516824c2e115a83d15e1b4d5adbe1deab7c2e0
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-syslog 
--mandir=$NEOTERM_PREFIX/share/man
"

neoterm_step_pre_configure() {
	autoreconf -vfi
}
