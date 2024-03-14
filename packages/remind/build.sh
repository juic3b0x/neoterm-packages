NEOTERM_PKG_HOMEPAGE=https://dianne.skoll.ca/projects/remind/
NEOTERM_PKG_DESCRIPTION="Sophisticated calendar and alarm program"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:04.03.02"
NEOTERM_PKG_SRCURL=https://fossies.org/linux/misc/remind-${NEOTERM_PKG_VERSION:2}.tar.xz
NEOTERM_PKG_SHA256=e3ab6b83aab925988c5a69e70a71d8d0fe8049daeed2e9cb081dcb2f3b5e805a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-glob"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_RM_AFTER_INSTALL="bin/tkremind share/man/man1/tkremind.1 bin/cm2rem.tcl share/man/man1/cm2rem.1"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
