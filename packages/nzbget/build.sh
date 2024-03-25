NEOTERM_PKG_HOMEPAGE=https://nzbget.net/
NEOTERM_PKG_DESCRIPTION="The most efficient usenet downloader"
# License: GPL-2.0-with-OpenSSL-exception
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=21.1
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_SRCURL=https://github.com/nzbget/nzbget/releases/download/v${NEOTERM_PKG_VERSION}/nzbget-${NEOTERM_PKG_VERSION}-src.tar.gz
NEOTERM_PKG_SHA256=4e8fc1beb80dc2af2d6a36a33a33f44dedddd4486002c644f4c4793043072025
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libxml2, ncurses, openssl, p7zip, zlib"
NEOTERM_PKG_RECOMMENDS="unrar"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_SERVICE_SCRIPT=("nzbget" 'exec nzbget -s 2>&1')

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "if [ -z \"\$2\" ]; then" >> postinst # Run only on fresh install, not on upgrade
	echo "sed -e 's|^\(CertStore=\).*|\1$NEOTERM_PREFIX/etc/tls/cert.pem|g" >> postinst
	echo "s|^\(ControlPassword=\).*|\1|g' $NEOTERM_PREFIX/share/nzbget/nzbget.conf > $NEOTERM_PREFIX/etc/nzbget.conf" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
