NEOTERM_PKG_HOMEPAGE=https://xz.tukaani.org/xz-utils/
NEOTERM_PKG_DESCRIPTION="XZ-format compression library"
NEOTERM_PKG_LICENSE="LGPL-2.1, GPL-2.0, GPL-3.0"
NEOTERM_PKG_LICENSE_FILE="COPYING, COPYING.GPLv2, COPYING.GPLv3, COPYING.LGPLv2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.6.1"
NEOTERM_PKG_SRCURL=https://github.com/tukaani-project/xz/releases/download/v${NEOTERM_PKG_VERSION}/xz-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=f334777310ca3ae9ba07206d78ed286a655aa3f44eec27854f740c26b2cd2ed0
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
