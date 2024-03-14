NEOTERM_PKG_HOMEPAGE=http://www.nongnu.org/oath-toolkit/
NEOTERM_PKG_DESCRIPTION="One-time password components"
NEOTERM_PKG_LICENSE="GPL-3.0, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.6.7
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=http://download.savannah.nongnu.org/releases/oath-toolkit/oath-toolkit-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=36eddfce8f2f36347fb257dbf878ba0303a2eaafe24eaa071d5cd302261046a9
NEOTERM_PKG_DEPENDS="libxml2, xmlsec"
NEOTERM_PKG_BREAKS="oathtool-dev"
NEOTERM_PKG_REPLACES="oathtool-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-pam"

neoterm_step_post_configure() {
	# Fix out-of-tree build
	local _gdoc="./libpskc/man/gdoc"
	if [ ! -e "${_gdoc}" ]; then
		ln -sf "$NEOTERM_PKG_SRCDIR/libpskc/man/gdoc" "${_gdoc}"
	fi

	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libpskc/libtool
}
