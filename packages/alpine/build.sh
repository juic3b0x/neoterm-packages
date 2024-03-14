NEOTERM_PKG_HOMEPAGE=http://alpine.x10host.com/
NEOTERM_PKG_DESCRIPTION="Fast, easy to use email client"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.26
NEOTERM_PKG_SRCURL=https://fossies.org/linux/misc/alpine-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=c0779c2be6c47d30554854a3e14ef5e36539502b331068851329275898a9baba
NEOTERM_PKG_DEPENDS="coreutils, libcrypt, ncurses, openssl, openssl-tool"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-debug
--with-c-client-target=lnx
--without-krb5
--without-ldap
--without-pthread
--without-tcl
--with-system-pinerc=${NEOTERM_PREFIX}/etc/pine.conf
--with-passfile=$NEOTERM_ANDROID_HOME/.pine-passfile
--with-ssl-dir=$NEOTERM_PREFIX
--with-ssl-certs-dir=$NEOTERM_PREFIX/etc/ssl/certs
--with-ssl-key-dir=$NEOTERM_PREFIX/etc/ssl/private
"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	export TCC=$CC
	export TRANLIB=$RANLIB
	export SPELLPROG=${NEOTERM_PREFIX}/bin/hunspell
	export alpine_SSLVERSION=old
	export TPATH=$PATH

	export LIBS="-lcrypt"

	# To get S_IREAD and friends:
	CPPFLAGS+=" -D__USE_BSD"

	cp $NEOTERM_PKG_BUILDER_DIR/pine.conf $NEOTERM_PREFIX/etc/pine.conf

	touch $NEOTERM_PKG_SRCDIR/imap/lnxok

	autoreconf -fi
}

neoterm_step_post_configure() {
	cd pith
	$CC_FOR_BUILD help_c_gen.c -o help_c_gen
	$CC_FOR_BUILD help_h_gen.c -o help_h_gen
	touch -d "next hour" help_c_gen help_h_gen
}
neoterm_step_create_debscripts() {

	echo "#!$NEOTERM_PREFIX/bin/sh" >> postinst
	echo "if [ ! -e $NEOTERM_ANDROID_HOME/.alpine-smime/.pwd/MasterPassword.crt ] && [ ! -e $HOME/.alpine-smime/.pwd/MasterPassword.key ]; then" >> postinst
	echo "echo 'warning making a passwordless masterpasword file'" >> postinst
	echo "mkdir -p \$HOME/.alpine-smime/public \$HOME/.alpine-smime/.pwd \$HOME/.alpine-smime/private \$HOME/.alpine-smime/ca" >> postinst
	echo "openssl req -x509 -newkey rsa:2048 -keyout \$HOME/.alpine-smime/.pwd/MasterPassword.key -out \$HOME/.alpine-smime/.pwd/MasterPassword.crt -days 10000 -nodes -subj '/C=US/ST=dont/L=use/O=this Name/OU=for/CN=anything.com.neoterm'" >> postinst
	echo "touch \$HOME/.pine-passfile" >> postinst
	echo "fi" >> postinst
}

