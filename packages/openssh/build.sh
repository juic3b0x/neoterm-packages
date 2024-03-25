NEOTERM_PKG_HOMEPAGE=https://www.openssh.com/
NEOTERM_PKG_DESCRIPTION="Secure shell for logging into a remote machine"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="9.7p1"
NEOTERM_PKG_SRCURL=https://github.com/openssh/openssh-portable/archive/refs/tags/V_$(sed 's/\./_/g; s/p/_P/g' <<< $NEOTERM_PKG_VERSION).tar.gz
NEOTERM_PKG_SHA256=f0c22a08eeaa7dfbae3ba553031a8c7d5322e498216d99ad8074a076b28c6f90
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="krb5, ldns, libandroid-support, libedit, openssh-sftp-server, openssl, neoterm-auth, zlib"
NEOTERM_PKG_CONFLICTS="dropbear"
# --disable-strip to prevent host "install" command to use "-s", which won't work for target binaries:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-etc-default-login
--disable-lastlog
--disable-libutil
--disable-pututline
--disable-pututxline
--disable-strip
--disable-utmp
--disable-utmpx
--disable-wtmp
--disable-wtmpx
--sysconfdir=$NEOTERM_PREFIX/etc/ssh
--with-cflags=-Dfd_mask=int
--with-ldns
--with-libedit
--with-mantype=man
--without-ssh1
--without-stackprotect
--with-pid-dir=$NEOTERM_PREFIX/var/run
--with-privsep-path=$NEOTERM_PREFIX/var/empty
--with-xauth=$NEOTERM_PREFIX/bin/xauth
--with-kerberos5
ac_cv_func_endgrent=yes
ac_cv_func_fmt_scaled=no
ac_cv_func_getlastlogxbyname=no
ac_cv_func_readpassphrase=no
ac_cv_func_strnvis=no
ac_cv_header_sys_un_h=yes
ac_cv_lib_crypt_crypt=no
ac_cv_search_getrrsetbyname=no
ac_cv_func_bzero=yes
"
# Configure script require this variable to set
# prefixed path to program 'passwd'
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="PATH_PASSWD_PROG=${NEOTERM_PREFIX}/bin/passwd"

NEOTERM_PKG_MAKE_INSTALL_TARGET="install-nokeys"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/slogin share/man/man1/slogin.1"
NEOTERM_PKG_CONFFILES="etc/ssh/ssh_config etc/ssh/sshd_config"
NEOTERM_PKG_SERVICE_SCRIPT=("sshd" 'exec sshd -D -e 2>&1')

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	autoreconf

	CPPFLAGS+=" -DHAVE_ATTRIBUTE__SENTINEL__=1 -DBROKEN_SETRESGID"
	LD=$CC # Needed to link the binaries
}

neoterm_step_post_configure() {
	# We need to remove this file before installing, since otherwise the
	# install leaves it alone which means no updated timestamps.
	rm -Rf $NEOTERM_PREFIX/etc/moduli
}

neoterm_step_post_make_install() {
	echo -e "PrintMotd yes\nPasswordAuthentication yes\nSubsystem sftp $NEOTERM_PREFIX/libexec/sftp-server" > $NEOTERM_PREFIX/etc/ssh/sshd_config
	printf "SendEnv LANG\n" > $NEOTERM_PREFIX/etc/ssh/ssh_config
	install -Dm700 $NEOTERM_PKG_BUILDER_DIR/source-ssh-agent.sh $NEOTERM_PREFIX/bin/source-ssh-agent
	install -Dm700 $NEOTERM_PKG_BUILDER_DIR/ssh-with-agent.sh $NEOTERM_PREFIX/bin/ssha
	install -Dm700 $NEOTERM_PKG_BUILDER_DIR/sftp-with-agent.sh $NEOTERM_PREFIX/bin/sftpa
	install -Dm700 $NEOTERM_PKG_BUILDER_DIR/scp-with-agent.sh $NEOTERM_PREFIX/bin/scpa

	# Install ssh-copy-id:
	sed -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
		$NEOTERM_PKG_BUILDER_DIR/ssh-copy-id.sh \
		> $NEOTERM_PREFIX/bin/ssh-copy-id
	chmod +x $NEOTERM_PREFIX/bin/ssh-copy-id

	mkdir -p $NEOTERM_PREFIX/var/run
	echo "OpenSSH needs this folder to put sshd.pid in" >> $NEOTERM_PREFIX/var/run/README.openssh

	mkdir -p $NEOTERM_PREFIX/etc/ssh/
	cp $NEOTERM_PKG_SRCDIR/moduli $NEOTERM_PREFIX/etc/ssh/moduli
}

neoterm_step_post_massage() {
	# Verify that we have man pages packaged (#1538).
	local manpage
	for manpage in ssh-keyscan.1 ssh-add.1 scp.1 ssh-agent.1 ssh.1; do
		if [ ! -f share/man/man1/$manpage.gz ]; then
			neoterm_error_exit "Missing man page $manpage"
		fi
	done
}

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "mkdir -p \$HOME/.ssh" >> postinst
	echo "touch \$HOME/.ssh/authorized_keys" >> postinst
	echo "chmod 700 \$HOME/.ssh" >> postinst
	echo "chmod 600 \$HOME/.ssh/authorized_keys" >> postinst
	echo "" >> postinst
	echo "for a in rsa dsa ecdsa ed25519; do" >> postinst
	echo "	  KEYFILE=$NEOTERM_PREFIX/etc/ssh/ssh_host_\${a}_key" >> postinst
	echo "	  test ! -f \$KEYFILE && ssh-keygen -N '' -t \$a -f \$KEYFILE" >> postinst
	echo "done" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}

neoterm_pkg_auto_update() {
	local latest_tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}" newest-tag)"
	[[ -z "${latest_tag}" ]] && neoterm_error_exit "ERROR: Unable to get tag from ${NEOTERM_PKG_SRCURL}"
	local version="$(echo ${latest_tag} | sed -E 's/V_([0-9]+)_([0-9]+)_P([0-9]+)/\1.\2p\3/')"
	neoterm_pkg_upgrade_version $version
}
