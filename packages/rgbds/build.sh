NEOTERM_PKG_HOMEPAGE=https://rgbds.gbdev.io
NEOTERM_PKG_DESCRIPTION="Rednex Game Boy Development System - An assembly toolchain for the Nintendo Game Boy & Game Boy Color"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.7.0"
NEOTERM_PKG_SRCURL=https://github.com/gbdev/rgbds/releases/download/v${NEOTERM_PKG_VERSION}/rgbds-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b3e2bae43e679492efd6f128dc6e951dd4b1b9ef75905df937a9b9fa67bcfaf2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-spawn, libandroid-support, libc++, libpng"

neoterm_step_pre_configure() {
	export LDFLAGS+=" -landroid-spawn"
}
