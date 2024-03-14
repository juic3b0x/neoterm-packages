NEOTERM_PKG_HOMEPAGE=https://github.com/WindSoilder/hors
NEOTERM_PKG_DESCRIPTION="Instant coding answers via the command line (howdoi in rust)"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION=0.8.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/WindSoilder/hors/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=22419b26f64a2793759d3a3616df58196897cd9227074f475aeb3e1c366296a9
NEOTERM_PKG_BUILD_DEPENDS="binutils-cross"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" = arm ]; then
		neoterm_setup_no_integrated_as
	fi

	rm -f Makefile
}
