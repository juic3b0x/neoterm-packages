NEOTERM_PKG_HOMEPAGE=http://rigaux.org/hexedit.html
NEOTERM_PKG_DESCRIPTION="view and edit files in hexadecimal or in ASCII"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6
NEOTERM_PKG_SRCURL=https://github.com/pixel/hexedit/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=598906131934f88003a6a937fab10542686ce5f661134bc336053e978c4baae3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	./autogen.sh
}
