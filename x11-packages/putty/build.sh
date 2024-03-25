NEOTERM_PKG_HOMEPAGE=https://www.chiark.greenend.org.uk/~sgtatham/putty/
NEOTERM_PKG_DESCRIPTION="A terminal integrated SSH/Telnet client"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.80"
NEOTERM_PKG_SRCURL=https://the.earth.li/~sgtatham/putty/${NEOTERM_PKG_VERSION}/putty-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2013c83a721b1753529e9090f7c3830e8fe4c80a070ccce764539badb3f67081
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, libx11, pango"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
