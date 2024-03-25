NEOTERM_PKG_HOMEPAGE=https://www.gnupg.org/related_software/libgpg-error/
NEOTERM_PKG_DESCRIPTION="Small library that defines common error values for all GnuPG components"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.47
NEOTERM_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=9e3c670966b96ecc746c28c2c419541e3bcb787d1a73930f5e5f5e1bcbbb9bdb
NEOTERM_PKG_BREAKS="libgpg-error-dev"
NEOTERM_PKG_REPLACES="libgpg-error-dev"
NEOTERM_PKG_RM_AFTER_INSTALL="share/common-lisp"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-install-gpg-error-config
"

neoterm_step_post_get_source() {
	# Upstream only has Android definitions for platform-specific lock objects.
	# See https://lists.gnupg.org/pipermail/gnupg-devel/2014-January/028203.html
	# for how to generate a lock-obj header file on devices.

	# For aarch64 this was generated on a device:
	cp $NEOTERM_PKG_BUILDER_DIR/lock-obj-pub.aarch64-unknown-linux-android.h $NEOTERM_PKG_SRCDIR/src/syscfg/

	if [ $NEOTERM_ARCH = i686 ]; then
		# Android i686 has same config as arm (verified by generating a file on a i686 device):
		cp $NEOTERM_PKG_SRCDIR/src/syscfg/lock-obj-pub.arm-unknown-linux-androideabi.h \
		   $NEOTERM_PKG_SRCDIR/src/syscfg/lock-obj-pub.linux-android.h
	elif [ $NEOTERM_ARCH = x86_64 ]; then
		# FIXME: Generate on device.
		cp $NEOTERM_PKG_BUILDER_DIR/lock-obj-pub.aarch64-unknown-linux-android.h \
			$NEOTERM_PKG_SRCDIR/src/syscfg/lock-obj-pub.linux-android.h
	fi
}

neoterm_step_pre_configure() {
	autoreconf -fi
	# USE_POSIX_THREADS_WEAK is being enabled for on-device build and causes
	# errors, so force-disable it.
	sed -i 's/USE_POSIX_THREADS_WEAK/DONT_USE_POSIX_THREADS_WEAK/g' configure
}
