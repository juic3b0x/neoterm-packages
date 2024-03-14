NEOTERM_PKG_HOMEPAGE=https://web.mit.edu/kerberos
NEOTERM_PKG_DESCRIPTION="The Kerberos network authentication system"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="../NOTICE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.21.2"
NEOTERM_PKG_SRCURL=https://fossies.org/linux/misc/krb5-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=9560941a9d843c0243a71b17a7ac6fe31c7cebb5bce3983db79e52ae7e850491
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support, libandroid-glob, libresolv-wrapper, readline, openssl, libdb"
NEOTERM_PKG_BREAKS="krb5-dev"
NEOTERM_PKG_REPLACES="krb5-dev"
NEOTERM_PKG_CONFFILES="etc/krb5.conf var/krb5kdc/kdc.conf"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-readline
--without-system-verto
--enable-dns-for-realm
--sbindir=$NEOTERM_PREFIX/bin
--with-size-optimizations
--with-system-db
DEFCCNAME=$NEOTERM_PREFIX/tmp/krb5cc_%{uid}
DEFKTNAME=$NEOTERM_PREFIX/etc/krb5.keytab
DEFCKTNAME=$NEOTERM_PREFIX/var/krb5/user/%{euid}/client.keytab
"

neoterm_step_post_get_source() {
	NEOTERM_PKG_SRCDIR+="/src"
}

neoterm_step_pre_configure() {
	# cannot test these when cross compiling
	export krb5_cv_attr_constructor_destructor='yes,yes'
	export ac_cv_func_regcomp='yes'
	export ac_cv_printf_positional='yes'

	# bionic doesn't have getpass
	cp "$NEOTERM_PKG_BUILDER_DIR/netbsd_getpass.c" "$NEOTERM_PKG_SRCDIR/clients/kpasswd/"

	CFLAGS="$CFLAGS -D_PASSWORD_LEN=PASS_MAX"
	export LIBS="-landroid-glob -lresolv_wrapper"
}

neoterm_step_post_make_install() {
	# Enable logging to STDERR by default
	echo -e "\tdefault = STDERR" >> $NEOTERM_PKG_SRCDIR/config-files/krb5.conf

	# Sample KDC config file
	install -dm 700 $NEOTERM_PREFIX/var/krb5kdc
	install -pm 600 $NEOTERM_PKG_SRCDIR/config-files/kdc.conf $NEOTERM_PREFIX/var/krb5kdc/kdc.conf

	# Default configuration file
	install -pm 600 $NEOTERM_PKG_SRCDIR/config-files/krb5.conf $NEOTERM_PREFIX/etc/krb5.conf

	install -dm 700 $NEOTERM_PREFIX/share/aclocal
	install -m 600 $NEOTERM_PKG_SRCDIR/util/ac_check_krb5.m4 $NEOTERM_PREFIX/share/aclocal
}
