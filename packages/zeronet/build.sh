NEOTERM_PKG_HOMEPAGE=https://zeronet.io/
NEOTERM_PKG_DESCRIPTION="Decentralized websites using Bitcoin crypto and BitTorrent network"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.1
NEOTERM_PKG_REVISION=8
NEOTERM_PKG_SRCURL=https://github.com/HelloZeroNet/ZeroNet/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=78a27e1687d8e3699a854b77b516c95b30a8ba667f7ebbef0aabf7ec6ec7272d
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_CONFFILES="etc/zeronet.conf"
NEOTERM_PKG_DEPENDS="bash, clang, make, openssl-tool, pkg-config, python"
NEOTERM_PKG_RECOMMENDS="tor"

neoterm_step_make_install() {
	# ZeroNet sources.
	mkdir -p "$NEOTERM_PREFIX"/opt
	rm -rf "$NEOTERM_PREFIX"/opt/zeronet
	cp -a "$NEOTERM_PKG_SRCDIR" "$NEOTERM_PREFIX"/opt/zeronet

	# Installer.
	install -Dm700 "$NEOTERM_PKG_BUILDER_DIR"/installer.sh \
		"$NEOTERM_PREFIX"/opt/zeronet/installer.sh
	sed -i "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" \
		"$NEOTERM_PREFIX"/opt/zeronet/installer.sh

	# Wrapper.
	install -Dm700 "$NEOTERM_PKG_BUILDER_DIR"/zeronet.sh \
		"$NEOTERM_PREFIX"/bin/zeronet
	sed -i "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" \
		"$NEOTERM_PREFIX"/bin/zeronet

	# Configuration file.
	install -Dm600 "$NEOTERM_PKG_BUILDER_DIR"/zeronet.conf \
		"$NEOTERM_PREFIX"/etc/zeronet.conf
}

neoterm_step_post_massage() {
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX"/var/lib/zeronet
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX"/var/log/zeronet
}

neoterm_step_create_debscripts() {
	{
		echo "#!$NEOTERM_PREFIX/bin/sh"
		echo "bash $NEOTERM_PREFIX/opt/zeronet/installer.sh"
	} > ./postinst
	chmod 755 ./postinst

	{
		echo "#!$NEOTERM_PREFIX/bin/sh"
		echo "[ \$1 != remove ] && exit 0"
		echo "echo \"Removing ZeroNet files...\""
		echo "rm -rf $NEOTERM_PREFIX/opt/zeronet"
		echo "rm -rf $NEOTERM_PREFIX/var/lib/zeronet"
		echo "rm -rf $NEOTERM_PREFIX/var/log/zeronet"
		echo "exit 0"
	} > ./postrm
	chmod 755 ./postrm
}
