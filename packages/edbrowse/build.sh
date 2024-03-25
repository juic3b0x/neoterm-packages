NEOTERM_PKG_HOMEPAGE=https://edbrowse.org/
NEOTERM_PKG_DESCRIPTION="Line based editor, browser, and mail client"
# License: GPL-2.0-or-later
NEOTERM_PKG_LICENSE="GPL-2.0, MIT"
NEOTERM_PKG_LICENSE_FILE="COPYING, LICENSE.quickjs"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.8.9"
NEOTERM_PKG_SRCURL=https://github.com/CMB/edbrowse/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=dae133d6b52be88864f8e696b8fc4ca4185e04857707713da8a0085bedf04e6b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libandroid-glob, libcurl, openssl, pcre2, readline, unixodbc"
NEOTERM_PKG_BUILD_DEPENDS="quickjs"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="-C src
PREFIX=$NEOTERM_PREFIX
QUICKJS_INCLUDE=$NEOTERM_PREFIX/include/quickjs
"

neoterm_step_post_get_source() {
	cp $NEOTERM_PKG_BUILDER_DIR/LICENSE.quickjs ./
}
