NEOTERM_PKG_HOMEPAGE=https://e2fsprogs.sourceforge.net
NEOTERM_PKG_DESCRIPTION="EXT 2/3/4 filesystem utilities"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.0"
NEOTERM_PKG_LICENSE_FILE="NOTICE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.47.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v$NEOTERM_PKG_VERSION/e2fsprogs-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=144af53f2bbd921cef6f8bea88bb9faddca865da3fbc657cc9b4d2001097d5db
NEOTERM_PKG_CONFFILES="etc/mke2fs.conf"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_DEPENDS="libblkid, libuuid"
NEOTERM_PKG_BREAKS="e2fsprogs-dev"
NEOTERM_PKG_REPLACES="e2fsprogs-dev"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--sbindir=${NEOTERM_PREFIX}/bin
--enable-symlink-install
--enable-relative-symlinks
--disable-defrag
--disable-e2initrd-helper
--disable-fsck
--disable-libuuid
--disable-libblkid
--disable-uuidd
--with-crond_dir=${NEOTERM_PREFIX}/etc/cron.d"

# Remove com_err.h to avoid conflicting with krb5-dev:
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/compile_et
bin/e2scrub
bin/e2scrub_all
bin/mk_cmds
etc/cron.d
etc/e2scrub.conf
include/com_err.h
lib/e2fsprogs
share/et
share/ss
share/man/man1/compile_et.1
share/man/man1/mk_cmds.1
share/man/man8/e2scrub.8.gz
share/man/man8/e2scrub_all.8.gz"

neoterm_step_make_install() {
	make install install-libs
	install -Dm600 \
		"$NEOTERM_PKG_SRCDIR"/misc/mke2fs.conf.in \
		"$NEOTERM_PREFIX"/etc/mke2fs.conf
}
