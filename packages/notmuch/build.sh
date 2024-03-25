NEOTERM_PKG_HOMEPAGE=https://notmuchmail.org
NEOTERM_PKG_DESCRIPTION="Thread-based email index, search and tagging system"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.38.3"
NEOTERM_PKG_SRCURL=https://notmuchmail.org/releases/notmuch-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=9af46cc80da58b4301ca2baefcc25a40d112d0315507e632c0f3f0f08328d054
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib, libc++, libgmime, libtalloc, libxapian, zlib"
NEOTERM_PKG_BREAKS="notmuch-dev"
NEOTERM_PKG_REPLACES="notmuch-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	# Use python3 so that the python3-sphinx package is
	# found for man page generation.
	export PYTHON=python3

	cd $NEOTERM_PKG_SRCDIR
	XAPIAN_CONFIG=$NEOTERM_PREFIX/bin/xapian-config ./configure \
		--prefix=$NEOTERM_PREFIX \
		--without-api-docs \
		--without-desktop \
		--without-emacs \
		--without-ruby
}
