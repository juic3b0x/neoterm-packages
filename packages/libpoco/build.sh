NEOTERM_PKG_HOMEPAGE=https://pocoproject.org/
NEOTERM_PKG_DESCRIPTION="A comprehensive set of C++ libraries that cover all modern-day programming needs"
NEOTERM_PKG_LICENSE="BSL-1.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.13.2"
NEOTERM_PKG_SRCURL=https://github.com/pocoproject/poco/archive/refs/tags/poco-${NEOTERM_PKG_VERSION}-release.tar.gz
NEOTERM_PKG_SHA256=c01221870aa9bccedf1de39890279699207848fe61a0cfb6aeec7c5942c4627f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP='(?<=-)[^-]+(?=-)'
NEOTERM_PKG_DEPENDS="libc++, libexpat, libsqlite, openssl, pcre2, zlib"
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DPOCO_UNBUNDLED=ON"
