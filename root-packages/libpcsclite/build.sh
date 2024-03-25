NEOTERM_PKG_HOMEPAGE=https://pcsclite.apdu.fr/
NEOTERM_PKG_DESCRIPTION="Middleware to access a smart card using SCard API (PC/SC)."
NEOTERM_PKG_LICENSE="BSD 3-Clause, GPL-3.0, BSD 2-Clause, ISC"
NEOTERM_PKG_LICENSE_FILE="COPYING, GPL-3.0.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.0
NEOTERM_PKG_SRCURL=https://pcsclite.apdu.fr/files/pcsc-lite-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=d6c3e2b64510e5ed6fcd3323febf2cc2a8e5fda5a6588c7671f2d77f9f189356
NEOTERM_PKG_DEPENDS="python"
NEOTERM_PKG_BREAKS="libpcsclite-dev"
NEOTERM_PKG_REPLACES="libpcsclite-dev"
NEOTERM_PKG_BUILD_DEPENDS="flex"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--exec-prefix=$NEOTERM_PREFIX
--sbindir=$NEOTERM_PREFIX/bin
--enable-ipcdir=$NEOTERM_PREFIX/var/run
--disable-libsystemd
--disable-libudev"


neoterm_step_create_debscripts() {
	# "pcscd fails to start if this folder does not exist"
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "mkdir -p $NEOTERM_PREFIX/lib/pcsc/drivers" >> postinst
}
