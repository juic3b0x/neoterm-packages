NEOTERM_PKG_HOMEPAGE=https://aria2.github.io
NEOTERM_PKG_DESCRIPTION="Download utility supporting HTTP/HTTPS, FTP, BitTorrent and Metalink"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.37.0"
NEOTERM_PKG_SRCURL="https://github.com/aria2/aria2/releases/download/release-${NEOTERM_PKG_VERSION}/aria2-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=60a420ad7085eb616cb6e2bdf0a7206d68ff3d37fb5a956dc44242eb2f79b66b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag" # As of 2022-05-11T00:08:00 no github releases are available.
NEOTERM_PKG_DEPENDS="libc++, c-ares, libgnutls, libxml2, zlib"
# sqlite3 is only used for loading cookies from firefox or chrome:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-openssl
--with-gnutls
--without-libuv
--without-sqlite3
--without-libssh2
ac_cv_func_basename=yes
ac_cv_func_getaddrinfo=yes
ac_cv_func_gettimeofday=yes
ac_cv_func_sleep=yes
ac_cv_func_usleep=yes
ac_cv_search_getaddrinfo=no
"

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" = "arm" ]; then
		CXXFLAGS="${CFLAGS/-Oz/-Os}"
	fi
}
