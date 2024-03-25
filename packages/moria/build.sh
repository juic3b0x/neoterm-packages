NEOTERM_PKG_HOMEPAGE=https://umoria.org
NEOTERM_PKG_DESCRIPTION="Rogue-like game with an infinite dungeon"
NEOTERM_PKG_LICENSE="GPL-3.0-or-later"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.7.15
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/dungeons-of-moria/umoria/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=97f76a68b856dd5df37c20fc57c8a51017147f489e8ee8866e1764778b2e2d57
NEOTERM_PKG_DEPENDS="libc++, ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-Dbuild_dir=$NEOTERM_PKG_BUILDDIR"
NEOTERM_PKG_GROUPS="games"

neoterm_step_create_debscripts() {
	# Create scores file in a debscript, so an update to the package wouldn't erase any scores
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "DIR=$NEOTERM_PREFIX/lib/games/moria" >> postinst
	echo "mkdir -p \$DIR" >> postinst
	echo "touch \$DIR/scores.dat" >> postinst
	chmod 0755 postinst

	# https://github.com/neoterm/neoterm-packages/issues/1401
	echo "#!$NEOTERM_PREFIX/bin/sh" > prerm
	echo "cd $NEOTERM_PREFIX/lib/games/moria || exit" >> prerm
	echo "case \$1 in" >> prerm
	echo "purge|remove)" >> prerm
	echo "rm -f game.sav scores.dat" >> prerm
	echo "esac" >> prerm
	chmod 0755 prerm
}
