NEOTERM_PKG_HOMEPAGE=https://btrfs.readthedocs.io/en/latest/
NEOTERM_PKG_DESCRIPTION="Utilities for Btrfs filesystem"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=6.0.2
NEOTERM_PKG_SRCURL=https://github.com/kdave/btrfs-progs/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=561a99d402d2788586756fb2b90295f709ec339bd4466c05a6e7c439dd0fe2f4
NEOTERM_PKG_DEPENDS="e2fsprogs, liblzo, libuuid, util-linux, zlib, zstd"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-backtrace
--disable-libudev
--disable-python
"

neoterm_step_pre_configure() {
	sh autogen.sh

	CFLAGS+=" $CPPFLAGS"
}
