NEOTERM_PKG_HOMEPAGE=https://github.com/martijnvanbrummelen/nwipe
NEOTERM_PKG_DESCRIPTION="A program that will securely erase the entire contents of disks"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.36"
NEOTERM_PKG_SRCURL=https://github.com/martijnvanbrummelen/nwipe/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4165a02fdfbf91a22bf862b35f057d7672052ef02509c97387068b5df6bb5c5b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ncurses, ncurses-ui-libs, parted, libconfig"

neoterm_step_pre_configure() {
	autoreconf -fi
}
