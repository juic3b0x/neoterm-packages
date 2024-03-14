NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/chess/
NEOTERM_PKG_DESCRIPTION="Chess-playing program"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=6.2.9
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/chess/gnuchess-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ddfcc20bdd756900a9ab6c42c7daf90a2893bf7f19ce347420ce36baebc41890
NEOTERM_PKG_DEPENDS="readline"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/gnuchessu bin/gnuchessx"
NEOTERM_PKG_GROUPS="games"
