NEOTERM_PKG_HOMEPAGE=https://directory.fsf.org/wiki/Jove
NEOTERM_PKG_DESCRIPTION="Jove is a compact, powerful, Emacs-style text-editor."
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.17.5.3
NEOTERM_PKG_SRCURL=https://github.com/jonmacs/jove/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ca5a5fcf71009c7389d655d1f1ae8139710f6cc531be95581e4b375e67f098d2
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
JOVEHOME=$NEOTERM_PREFIX
SYSDEFS=-DLinux
LDLIBS=-lncursesw
"

neoterm_step_post_massage() {
	mkdir -p ./var/lib/jove/preserve
}
