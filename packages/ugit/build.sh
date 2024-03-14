NEOTERM_PKG_HOMEPAGE=https://github.com/Bhupesh-V/ugit
NEOTERM_PKG_DESCRIPTION="ugit helps you undo your last git command with grace. Your damage control git buddy"
NEOTERM_PKG_LICENSE=MIT
NEOTERM_PKG_MAINTAINER=@neoterm
NEOTERM_PKG_VERSION="5.8"
NEOTERM_PKG_SRCURL=$NEOTERM_PKG_HOMEPAGE/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=aedc5fd10b82ed8f3c2fc3ffb9d912863a7fec936a9e444a25e8a41123e2e90f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS='bash, fzf, ncurses-utils'
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	local bin="$(basename $NEOTERM_PKG_HOMEPAGE)"
	install -D "$bin" -t "$NEOTERM_PREFIX/bin"
	ln -sf "$NEOTERM_PREFIX/bin/$bin"  "$NEOTERM_PREFIX/bin/gitundo"
}
