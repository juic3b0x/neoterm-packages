NEOTERM_PKG_HOMEPAGE=https://github.com/vasi/squashfuse
NEOTERM_PKG_DESCRIPTION="FUSE filesystem to mount squashfs archives"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.5.2"
NEOTERM_PKG_SRCURL=https://github.com/vasi/squashfuse/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=db0238c5981dabbd80ee09ae15387f390091668ca060a7bc38047912491443d3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libfuse2, liblz4, liblzma, liblzo, zlib, zstd"

neoterm_step_pre_configure () {
	./autogen.sh
}
