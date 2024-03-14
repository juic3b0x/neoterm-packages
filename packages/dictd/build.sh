NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/dict/
NEOTERM_PKG_DESCRIPTION="Online dictionary client and server"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.13.1
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/dict/dictd/dictd-${NEOTERM_PKG_VERSION}/dictd-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e4f1a67d16894d8494569d7dc9442c15cc38c011f2b9631c7f1cc62276652a1b
NEOTERM_PKG_DEPENDS="libmaa, zlib"
NEOTERM_PKG_CONFFILES="etc/dict.conf"

neoterm_step_post_make_install() {
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/dict.conf $NEOTERM_PREFIX/etc/dict.conf
}
