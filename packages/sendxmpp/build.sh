NEOTERM_PKG_HOMEPAGE=https://sendxmpp.hostname.sk/
NEOTERM_PKG_DESCRIPTION="A perl-script to send XMPP (jabber) messages"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_VERSION=1.24
NEOTERM_PKG_SRCURL=https://github.com/lhost/sendxmpp/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=dfaf735b4585efd6b3b0f95db31203f9ab0fe607b50e75c6951bc18a6269837d
NEOTERM_PKG_DEPENDS="perl, clang, make"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin sendxmpp
}

neoterm_step_create_debscripts()  {
	cat <<- POSTINST_EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/bash
	set -e

	echo "Sideloading Perl Authen::SASL and Net::XMPP ..."
	cpan -fi Authen::SASL Net::XMPP

	exit 0
	POSTINST_EOF
}
