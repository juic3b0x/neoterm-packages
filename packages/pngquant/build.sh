NEOTERM_PKG_HOMEPAGE=https://pngquant.org
NEOTERM_PKG_DESCRIPTION="PNG image optimising utility"
# Licenses: GPL-3.0-or-later, HPND, BSD 2-Clause
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYRIGHT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.0.3"
NEOTERM_PKG_SRCURL=git+https://github.com/kornelski/pngquant
NEOTERM_PKG_GIT_BRANCH=${NEOTERM_PKG_VERSION}
NEOTERM_PKG_DEPENDS="littlecms, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_post_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man1 pngquant.1
}
