NEOTERM_PKG_HOMEPAGE=https://www.fossil-scm.org
NEOTERM_PKG_DESCRIPTION="DSCM with built-in wiki, http interface and server, tickets database"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_LICENSE_FILE="COPYRIGHT-BSD2.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.23"
NEOTERM_PKG_SRCURL=https://www.fossil-scm.org/home/tarball/version-$NEOTERM_PKG_VERSION/fossil-src-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=a94aec2609331cd6890c6725b55aea43041011863f3d84fdc380415af75233e4
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libsqlite, openssl, zlib"

neoterm_step_pre_configure() {
	# Avoid mixup of flags between cross compilation
	# and native build.
	CC="$CC $CPPFLAGS $CFLAGS $LDFLAGS"
	unset CFLAGS LDFLAGS
}

neoterm_step_configure() {
	$NEOTERM_PKG_SRCDIR/configure \
		--prefix=$NEOTERM_PREFIX \
		--host=$NEOTERM_HOST_PLATFORM \
		--json \
		--disable-internal-sqlite \
		--with-sqlite=$NEOTERM_PREFIX \
		--with-openssl=$NEOTERM_PREFIX \
		--with-zlib=$NEOTERM_PREFIX
}
