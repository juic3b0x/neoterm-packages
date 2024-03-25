NEOTERM_PKG_HOMEPAGE=https://github.com/ipmitool/ipmitool
NEOTERM_PKG_DESCRIPTION="Command-line interface to IPMI-enabled devices"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.8.19
NEOTERM_PKG_SRCURL=https://github.com/ipmitool/ipmitool/archive/refs/tags/IPMITOOL_${NEOTERM_PKG_VERSION//./_}.tar.gz
NEOTERM_PKG_SHA256=48b010e7bcdf93e4e4b6e43c53c7f60aa6873d574cbd45a8d86fa7aaeebaff9c
NEOTERM_PKG_DEPENDS="openssl, readline"

neoterm_step_pre_configure() {
	sh bootstrap
}

neoterm_pkg_auto_update() {
	local latest_tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}")"
	[[ -z "${latest_tag}" ]] && neoterm_error_exit "ERROR: Unable to get tag from ${NEOTERM_PKG_SRCURL}"
	neoterm_pkg_upgrade_version "$(sed -n 's/^IPMITOOL_\([0-9]\+\)_\([0-9]\+\)_\([0-9]\+\)$/\1.\2.\3/p' <<< ${latest_tag})"
}
