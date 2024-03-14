NEOTERM_PKG_HOMEPAGE=https://matt.ucc.asn.au/dropbear/dropbear.html
NEOTERM_PKG_DESCRIPTION="Small SSH server and client"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2022.83
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://matt.ucc.asn.au/dropbear/releases/dropbear-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=bc5a121ffbc94b5171ad5ebe01be42746d50aa797c9549a4639894a16749443b
NEOTERM_PKG_DEPENDS="neoterm-auth, zlib"
NEOTERM_PKG_SUGGESTS="openssh-sftp-server"
NEOTERM_PKG_CONFLICTS="openssh"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-syslog --disable-utmp --disable-utmpx --disable-wtmp --disable-static"
# Avoid linking to libcrypt for server password authentication:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_lib_crypt_crypt=no"
# build a multi-call binary & enable progress info in 'scp'
NEOTERM_PKG_EXTRA_MAKE_ARGS="MULTI=1 SCPPROGRESS=1"

neoterm_step_pre_configure() {
	export LIBS="-lneoterm-auth"
}

neoterm_step_post_make_install() {
	ln -sf "dropbearmulti" "${NEOTERM_PREFIX}/bin/ssh"
}

neoterm_step_create_debscripts() {
	{
	echo "#!$NEOTERM_PREFIX/bin/sh"
	echo "mkdir -p $NEOTERM_PREFIX/etc/dropbear"
	echo "for a in rsa ecdsa ed25519; do"
	echo "	KEYFILE=$NEOTERM_PREFIX/etc/dropbear/dropbear_\${a}_host_key"
	echo "	test ! -f \$KEYFILE && dropbearkey -t \$a -f \$KEYFILE"
	echo "done"
	echo "exit 0"
	} > postinst
	chmod 0755 postinst
}
