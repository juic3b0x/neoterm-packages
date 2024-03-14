NEOTERM_PKG_HOMEPAGE=http://dar.linux.free.fr/
NEOTERM_PKG_DESCRIPTION="A full featured command-line backup tool, short for Disk ARchive"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.7.13"
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/dar/dar/${NEOTERM_PKG_VERSION}/dar-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2d563b5d1d928a3eecab719cc22d43320786c52053f4e3a557cdf1c84b120f4c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="attr, libbz2, libc++, libgcrypt, libgpg-error, liblzma, liblzo, zlib, zstd"
NEOTERM_PKG_BUILD_IN_SRC=
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-dar-static "

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH_BITS" = "32" ]; then
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-mode=32"
	else
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-mode=64"
	fi
	CXXFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
