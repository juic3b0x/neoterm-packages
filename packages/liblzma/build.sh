NEOTERM_PKG_HOMEPAGE=https://xz.tukaani.org/xz-utils/
NEOTERM_PKG_DESCRIPTION="XZ-format compression library"
NEOTERM_PKG_LICENSE="LGPL-2.1, GPL-2.0, GPL-3.0"
NEOTERM_PKG_LICENSE_FILE="COPYING, COPYING.GPLv2, COPYING.GPLv3, COPYING.LGPLv2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.6.1+really5.4.5"
NEOTERM_PKG_SRCURL=https://kali.download/kali/pool/main/x/xz-utils/xz-utils_${NEOTERM_PKG_VERSION}.orig.tar.xz
NEOTERM_PKG_SHA256=da9dec6c12cf2ecf269c31ab65b5de18e8e52b96f35d5bcd08c12b43e6878803
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="liblzma-dev"
NEOTERM_PKG_REPLACES="liblzma-dev"
NEOTERM_PKG_ESSENTIAL=true
# seccomp prevents SYS_landlock_create_ruleset
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-sandbox=no
"

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/liblzma.so.5"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done

	# Check if SONAME is properly set:
	if ! readelf -d lib/liblzma.so | grep -q '(SONAME).*\[liblzma\.so\.'; then
		neoterm_error_exit "SONAME of liblzma.so is not properly set."
	fi
}
