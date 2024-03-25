NEOTERM_PKG_HOMEPAGE=https://github.com/libfuse/libfuse
NEOTERM_PKG_DESCRIPTION="FUSE (Filesystem in Userspace) is an interface for userspace programs to export a filesystem to the Linux kernel"
NEOTERM_PKG_LICENSE="LGPL-2.1, GPL-2.0"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION=2.9.9
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/libfuse/libfuse/archive/fuse-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e57a24721177c3b3dd71cb9239ca46b4dee283db9388d48f7ccd256184982194
#that package is a snapshot, it does not need to be updated.
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libiconv"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-example
--disable-mtab
"

NEOTERM_PKG_RM_AFTER_INSTALL="
etc/init.d
etc/udev
"

neoterm_step_pre_configure() {
	export MOUNT_FUSE_PATH=$NEOTERM_PREFIX/bin
	export UDEV_RULES_PATH=$NEOTERM_PREFIX/etc/udev/rules.d
	export INIT_D_PATH=$NEOTERM_PREFIX/etc/init.d
	./makeconf.sh
}
