NEOTERM_PKG_HOMEPAGE=https://www.polyomino.org.uk/computer/software/bsd-games/
NEOTERM_PKG_DESCRIPTION="Classic text mode games from UNIX folklore"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="LICENSE, adventure/LICENSE, atc/LICENSE, battlestar/LICENSE, caesar/LICENSE, dab/LICENSE, drop4/LICENSE, gofish/LICENSE, gomoku/LICENSE, hangman/LICENSE, robots/LICENSE, sail/LICENSE, snake/LICENSE, spirhunt/LICENSE, worm/LICENSE, wump/LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:3.3
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/bsd-games/bsd-games-${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=78bfdf7f4e1f61ed42ad1209ef52520b89a583bd511e9606b8162f813078048d
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_GROUPS="games"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--localstatedir=$NEOTERM_PREFIX/games"
