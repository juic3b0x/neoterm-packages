NEOTERM_PKG_HOMEPAGE=https://www.dyne.org/software/frei0r/
NEOTERM_PKG_DESCRIPTION="Minimalistic plugin API for video effects"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.3.1"
NEOTERM_PKG_SRCURL=https://github.com/dyne/frei0r/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=dd6dbe49ba743421d8ced07781ca09c2ac62522beec16abf1750ef6fe859ddc9
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libcairo"
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DWITHOUT_GAVL=ON -DWITHOUT_OPENCV=ON"

neoterm_pkg_auto_update() {
	local latest_tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}")"
	[[ -z "${latest_tag}" ]] && neoterm_error_exit "ERROR: Unable to get tag from ${NEOTERM_PKG_SRCURL}"
	neoterm_pkg_upgrade_version "${latest_tag#v}"
}
