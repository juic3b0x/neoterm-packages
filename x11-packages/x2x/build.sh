NEOTERM_PKG_HOMEPAGE=https://github.com/dottedmag/x2x
NEOTERM_PKG_DESCRIPTION="Allows the keyboard, mouse on one X display to be used to control another X display"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:1.30-10
NEOTERM_PKG_SRCURL=https://github.com/dottedmag/x2x/archive/refs/tags/debian/${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=f41d5ed55d4b05fe28ab8c07bf41e19cdafcc6ecd08f588679aa0ee48f1eb627
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libx11, libxext, libxtst"

neoterm_step_pre_configure() {
	./bootstrap.sh
}
