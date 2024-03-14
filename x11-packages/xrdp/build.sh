NEOTERM_PKG_HOMEPAGE=https://github.com/neutrinolabs/xrdp
NEOTERM_PKG_DESCRIPTION="An open source remote desktop protocol (RDP) server"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.9.25"
NEOTERM_PKG_SRCURL=https://github.com/neutrinolabs/xrdp/releases/download/v${NEOTERM_PKG_VERSION}/xrdp-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8fcd3a66003b46c648bce3b091f0d78460a2d63bc59c971565693593d94e21f5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-shmem, libx11, libxfixes, libxrandr, openssl, procps, tigervnc"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-pam
--enable-static
--enable-strict-locations
--with-socketdir=$NEOTERM_PREFIX/tmp/.xrdp
"

NEOTERM_PKG_CONFFILES="
etc/xrdp/cert.pem
etc/xrdp/key.pem
etc/xrdp/km-00000406.ini
etc/xrdp/km-00000407.ini
etc/xrdp/km-00000409.ini
etc/xrdp/km-0000040a.ini
etc/xrdp/km-0000040b.ini
etc/xrdp/km-0000040c.ini
etc/xrdp/km-00000410.ini
etc/xrdp/km-00000411.ini
etc/xrdp/km-00000412.ini
etc/xrdp/km-00000414.ini
etc/xrdp/km-00000415.ini
etc/xrdp/km-00000416.ini
etc/xrdp/km-00000419.ini
etc/xrdp/km-0000041d.ini
etc/xrdp/km-00000807.ini
etc/xrdp/km-00000809.ini
etc/xrdp/km-0000080a.ini
etc/xrdp/km-0000080c.ini
etc/xrdp/km-00000813.ini
etc/xrdp/km-00000816.ini
etc/xrdp/km-0000100c.ini
etc/xrdp/km-00010409.ini
etc/xrdp/km-19360409.ini
etc/xrdp/pulse/default.pa
etc/xrdp/reconnectwm.sh
etc/xrdp/sesman.ini
etc/xrdp/startwm.sh
etc/xrdp/xrdp.ini
etc/xrdp/xrdp_keyboard.ini
"

NEOTERM_PKG_RM_AFTER_INSTALL="
etc/default
etc/init.d
etc/xrdp/cert.pem
etc/xrdp/key.pem
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -Wl,-rpath=${NEOTERM_PREFIX}/lib/xrdp -Wl,--enable-new-dtags"
	export LIBS="-landroid-shmem"
}

neoterm_step_create_debscripts() {
	{
		echo "#!${NEOTERM_PREFIX}/bin/sh"
		echo "if [ ! -e \"${NEOTERM_PREFIX}/etc/xrdp/rsakeys.ini\" ]; then"
		echo "    xrdp-keygen xrdp \"${NEOTERM_PREFIX}/etc/xrdp/rsakeys.ini\""
		echo "fi"
	} > ./postinst
	chmod 755 postinst
}
