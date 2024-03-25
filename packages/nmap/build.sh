NEOTERM_PKG_HOMEPAGE=https://nmap.org/
NEOTERM_PKG_DESCRIPTION="Utility for network discovery and security auditing"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=7.94
NEOTERM_PKG_SRCURL=https://nmap.org/dist/nmap-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=d71be189eec43d7e099bac8571509d316c4577ca79491832ac3e1217bc8f92cc
NEOTERM_PKG_DEPENDS="libc++, liblua54, libpcap, libssh2, openssl, pcre, resolv-conf, zlib"
NEOTERM_PKG_RECOMMENDS="nmap-ncat"
# --without-nmap-update to avoid linking against libsvn_client:
# --without-zenmap to avoid python scripts for graphical gtk frontend:
# --without-ndiff to avoid python2-using ndiff utility:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_STRIP=llvm-strip --enable-static --with-liblua=$NEOTERM_PREFIX --without-nmap-update --without-zenmap --without-ndiff"
NEOTERM_PKG_BUILD_IN_SRC=true
