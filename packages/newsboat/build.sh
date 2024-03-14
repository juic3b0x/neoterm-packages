NEOTERM_PKG_HOMEPAGE=https://newsboat.org/
NEOTERM_PKG_DESCRIPTION="RSS/Atom feed reader for the text console"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.34"
NEOTERM_PKG_SRCURL=https://newsboat.org/releases/${NEOTERM_PKG_VERSION}/newsboat-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=73d7b539b0c906f6843a1542e1904a02ae430e79d6be4d6f9e2e2034eac2434e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="json-c, libandroid-glob, libandroid-support, libc++, libcurl, libiconv, libsqlite, libxml2, ncurses, stfl"
NEOTERM_PKG_BUILD_DEPENDS="openssl"
NEOTERM_PKG_BUILD_IN_SRC=true
# NEOTERM_PKG_RM_AFTER_INSTALL="share/locale"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_bsd_main=no"
NEOTERM_PKG_CONFLICTS=newsbeuter
NEOTERM_PKG_REPLACES=newsbeuter

neoterm_step_pre_configure() {
	neoterm_setup_rust

	LDFLAGS+=" -liconv"

	export CXX_FOR_BUILD=g++
	export CXXFLAGS_FOR_BUILD="-O2"

	# Used by newsboat Makefile:
	export CARGO_BUILD_TARGET=$CARGO_TARGET_NAME

	export PKG_CONFIG_ALLOW_CROSS=1
}
