NEOTERM_PKG_HOMEPAGE=https://launchpad.net/pastebinit
NEOTERM_PKG_DESCRIPTION="Command-line pastebin client"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/felixonmars/pastebinit/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=30850b9dc6b3e9105321cee159d491891b3d3c03180440edffa296c7e1ac0c41
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="python"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi
}

neoterm_step_make_install() {
	cp pastebinit $NEOTERM_PREFIX/bin/
	xsltproc -''-nonet /usr/share/sgml/docbook/stylesheet/xsl/nwalsh/manpages/docbook.xsl pastebinit.xml
	cp pastebinit.1 $NEOTERM_PREFIX/share/man/man1/

	rm -Rf $NEOTERM_PREFIX/etc/pastebin.d
	mv pastebin.d $NEOTERM_PREFIX/etc
}
