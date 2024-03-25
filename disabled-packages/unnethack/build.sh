# Crashes with "Dungeon description not valid"
NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/apps/trac/unnethack
NEOTERM_PKG_DESCRIPTION="Dungeon crawling game, fork of NetHack"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.1.0
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/unnethack/unnethack/${NEOTERM_PKG_VERSION}/unnethack-${NEOTERM_PKG_VERSION}-20131208.tar.gz
NEOTERM_PKG_SHA256=d92886a02fd8f5a427d1acf628e12ee03852fdebd3af0e7d0d1279dc41c75762
# --with-owner=$USER to avoid unnethack trying to use a "games" user, --with-groups to avoid "bin" group
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-owner=$USER --with-group=$(groups | cut -d ' ' -f 1)"
NEOTERM_PKG_DEPENDS="gsl, ncurses"

# unnethack builds util/{makedefs,lev_comp,dgn_comp} binaries which are later used during the build.
# we first build these host tools in $NEOTERM_PKG_TMPDIR/host-build and copy them into the ordinary
# cross compile tree after configure, bumping their modification time so that they do not get rebuilt.

CFLAGS="$CFLAGS $CPPFLAGS $LDFLAGS"
export LFLAGS="$LDFLAGS"
LD="$CC"

neoterm_step_pre_configure() {
	# Create a host build for the makedefs binary
	mkdir $NEOTERM_PKG_TMPDIR/host-build
	cd $NEOTERM_PKG_TMPDIR/host-build
	ORIG_CC=$CC; export CC=gcc
	ORIG_CFLAGS=$CFLAGS; export CFLAGS=""
	ORIG_CPPFLAGS=$CPPFLAGS; export CPPFLAGS=""
	ORIG_CXXFLAGS=$CXXFLAGS; export CXXFLAGS=""
	ORIG_LDFLAGS=$LDFLAGS; export LDFLAGS=""
	ORIG_LFLAGS=$LFLAGS; export LFLAGS=""
	$NEOTERM_PKG_SRCDIR/configure --with-owner=$USER
	make
	make spec_levs
	make dungeon
	set +e
	make dlb
	set -e
	export CC=$ORIG_CC
	export CFLAGS=$ORIG_CFLAGS
	export CPPFLAGS=$ORIG_CPPFLAGS
	export CXXFLAGS=$ORIG_CXXFLAGS
	export LDFLAGS=$ORIG_LDFLAGS
	export LFLAGS=$ORIG_LFLAGS
}

neoterm_step_post_configure() {
	# Use the host built makedefs
	cp $NEOTERM_PKG_TMPDIR/host-build/util/makedefs $NEOTERM_PKG_BUILDDIR/util/makedefs
	cp $NEOTERM_PKG_TMPDIR/host-build/util/lev_comp $NEOTERM_PKG_BUILDDIR/util/lev_comp
	cp $NEOTERM_PKG_TMPDIR/host-build/util/dgn_comp $NEOTERM_PKG_BUILDDIR/util/dgn_comp
	cp $NEOTERM_PKG_TMPDIR/host-build/util/dlb $NEOTERM_PKG_BUILDDIR/util/dlb
	# Update timestamp so the binary does not get rebuilt
	touch -d "next hour" $NEOTERM_PKG_BUILDDIR/util/makedefs $NEOTERM_PKG_BUILDDIR/util/lev_comp $NEOTERM_PKG_BUILDDIR/util/dgn_comp $NEOTERM_PKG_BUILDDIR/util/dlb
}

neoterm_step_post_make_install() {
	# Add directory which must exist:
	mkdir -p $NEOTERM_PREFIX/var/unnethack/level
	echo "This directory stores locks" > $NEOTERM_PREFIX/var/unnethack/level/README
}
