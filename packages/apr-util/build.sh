NEOTERM_PKG_HOMEPAGE=https://apr.apache.org/
NEOTERM_PKG_DESCRIPTION="Apache Portable Runtime Utility Library"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.apache.org/apr/apr-util-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2b74d8932703826862ca305b094eef2983c27b39d5c9414442e9976a9acf1983
NEOTERM_PKG_DEPENDS="apr, libcrypt, libexpat, libiconv, libuuid"
NEOTERM_PKG_BREAKS="apr-util-dev"
NEOTERM_PKG_REPLACES="apr-util-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_pq_PQsendQueryPrepared=no
--with-apr=$NEOTERM_PREFIX
--without-sqlite3
"
NEOTERM_PKG_RM_AFTER_INSTALL="lib/aprutil.exp"
