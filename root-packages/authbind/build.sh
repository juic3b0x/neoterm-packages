NEOTERM_PKG_HOMEPAGE=https://www.chiark.greenend.org.uk/ucgi/~ian/git/authbind.git
NEOTERM_PKG_DESCRIPTION="Bind sockets to privileged ports without root"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1.3
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/a/authbind/authbind_${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0f5c70aa5e3b09497fa2f93992aef33872f5a4d50d68040534f7a9751cc579b7
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_MAKE_INSTALL_TARGET="install install_man"

neoterm_step_pre_configure() {
	sed -i 's|/\.$|/|g' Makefile
}

neoterm_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!$NEOTERM_PREFIX/bin/sh
		mkdir -p $NEOTERM_PREFIX/etc/authbind/byaddr
		mkdir -p $NEOTERM_PREFIX/etc/authbind/byport
		mkdir -p $NEOTERM_PREFIX/etc/authbind/byuid
		echo
		echo "********"
		echo "Remember to setuid root the helper program"
		echo
		echo "    $NEOTERM_PREFIX/libexec/authbind/helper"
		echo "********"
		echo
	EOF
}
