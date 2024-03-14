NEOTERM_PKG_HOMEPAGE=https://symas.com/lmdb/
NEOTERM_PKG_DESCRIPTION="LMDB implements a simplified variant of the BerkeleyDB (BDB) API"
NEOTERM_PKG_LICENSE="OpenLDAP"
NEOTERM_PKG_LICENSE_FILE="libraries/liblmdb/LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.9.32"
NEOTERM_PKG_SRCURL=https://git.openldap.org/openldap/openldap/-/archive/LMDB_${NEOTERM_PKG_VERSION}/openldap-LMDB_${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=70d553f80968f5117f2f3d4d7f0b89cb8fb69dadc35131263a2499bb58f7d015
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="-C libraries/liblmdb"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DMDB_USE_ROBUST=0"
}
