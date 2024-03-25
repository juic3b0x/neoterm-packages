NEOTERM_PKG_HOMEPAGE=https://github.com/libfuse/libfuse
NEOTERM_PKG_DESCRIPTION="FUSE (Filesystem in Userspace) is an interface for userspace programs to export a filesystem to the Linux kernel"
NEOTERM_PKG_LICENSE="LGPL-2.1, GPL-2.0"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION=3.15.1
NEOTERM_PKG_SRCURL=https://github.com/libfuse/libfuse/archive/fuse-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=cb93e170288804d2e83da9b69925d968655ed75883476773ba5268d08bb1d335

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Ddisable-mtab=true
-Dexamples=false
-Dtests=false
-Dsbindir=bin
-Dmandir=share/man
-Dudevrulesdir=$NEOTERM_PREFIX/etc/udev/rules.d
-Duseroot=false
"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -D__off64_t=off64_t"
}
