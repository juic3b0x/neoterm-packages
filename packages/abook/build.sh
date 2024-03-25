NEOTERM_PKG_HOMEPAGE=http://abook.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Abook is a text-based addressbook program designed to use with mutt mail client"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.6.1
NEOTERM_PKG_SRCURL=http://abook.sourceforge.net/devel/abook-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=f0a90df8694fb34685ecdd45d97db28b88046c15c95e7b0700596028bd8bc0f9
NEOTERM_PKG_DEPENDS="libandroid-support, ncurses, readline"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$NEOTERM_PREFIX/share/man"

neoterm_step_pre_configure() {
	aclocal
	automake --add-missing
	autoreconf
}
