NEOTERM_PKG_HOMEPAGE=https://sourceware.org/lvm2/
NEOTERM_PKG_DESCRIPTION="A device-mapper library from LVM2 package"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1, BSD 2-Clause"
NEOTERM_PKG_LICENSE_FILE="COPYING, COPYING.BSD, COPYING.LIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.03.23"
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/sourceware/lvm2/releases/LVM2.${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=74e794a9e9dee1bcf8a2065f65b9196c44fdf321e22d63b98ed7de8c9aa17a5d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libaio, libandroid-support, libblkid, readline"
NEOTERM_PKG_BREAKS="libdevmapper-dev"
NEOTERM_PKG_REPLACES="libdevmapper-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-pkgconfig
--disable-selinux
--with-default-system-dir=$NEOTERM_PREFIX/etc/lvm
--with-default-pid-dir=$NEOTERM_PREFIX/var/run
--with-default-profile-subdir=profile.d
--with-default-run-dir=$NEOTERM_PREFIX/var/run
--with-default-locking-dir=$NEOTERM_PREFIX/var/run/lock/lvm
--with-confdir=$NEOTERM_PREFIX/etc
--with-symvers=no
"

neoterm_step_pre_configure() {
	export CFLAGS="$CFLAGS $CPPFLAGS"
	export CLDFLAGS="$LDFLAGS"

	find "$NEOTERM_PKG_SRCDIR" -name '*.[ch]' | xargs -n 1 \
		sed -i 's/\([^A-Za-z0-9_]\)\(stack[^A-Za-z0-9_]\)/\1log_\2/g'
}
