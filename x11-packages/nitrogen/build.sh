NEOTERM_PKG_HOMEPAGE=http://projects.l3ib.org/nitrogen/
NEOTERM_PKG_DESCRIPTION="Background browser and setter for X windows"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.1
NEOTERM_PKG_SRCURL=https://github.com/l3ib/nitrogen/releases/download/${NEOTERM_PKG_VERSION}/nitrogen-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f40213707b7a3be87e556f65521cef8795bd91afda13dfac8f00c3550375837d
NEOTERM_PKG_DEPENDS="libc++, gtkmm2, gtk2"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CFLAGS+=" -I${NEOTERM_PREFIX}/include"
	autoreconf -fi
}
