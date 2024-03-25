NEOTERM_PKG_HOMEPAGE=https://rocksdb.org/
NEOTERM_PKG_DESCRIPTION="A persistent key-value store for flash and RAM storage"
NEOTERM_PKG_LICENSE="GPL-2.0, Apache-2.0, BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="COPYING, LICENSE.Apache, LICENSE.leveldb"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="8.11.3"
NEOTERM_PKG_SRCURL=https://github.com/facebook/rocksdb/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3b51d1d907ea13fab430bf052618610994f08cd8ed0b1341c3e89fe02e199f8e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="gflags, libc++"
NEOTERM_PKG_BUILD_DEPENDS="gflags-static"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DFAIL_ON_WARNINGS=OFF
-DPORTABLE=1
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=8

	local v=$(grep -E "ROCKSDB_MAJOR.[0-9]" include/rocksdb/version.h | \
			cut -d ' ' -f 3)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
