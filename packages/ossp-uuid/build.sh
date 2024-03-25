NEOTERM_PKG_HOMEPAGE=http://www.ossp.org/pkg/lib/uuid/
NEOTERM_PKG_DESCRIPTION="ISO-C:1999 uuid generator supporting DCE 1.1, ISO/IEC 11578:1996 and RFC 4122."
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.2
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=http://www.mirrorservice.org/sites/ftp.ossp.org/pkg/lib/uuid/uuid-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=11a615225baa5f8bb686824423f50e4427acd3f70d394765bdff32801f0fd5b0
NEOTERM_PKG_BREAKS="ossp-uuid-dev"
NEOTERM_PKG_REPLACES="ossp-uuid-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--includedir=$NEOTERM_PREFIX/include/ossp-uuid"

neoterm_step_pre_configure() {
	export ac_cv_va_copy=C99
}
