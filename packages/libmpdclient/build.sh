NEOTERM_PKG_HOMEPAGE=https://www.musicpd.org/libs/libmpdclient/
NEOTERM_PKG_DESCRIPTION="Asynchronous API library for interfacing MPD in the C, C++ & Objective C languages"
NEOTERM_PKG_LICENSE="BSD 2-Clause, BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="LICENSES/BSD-2-Clause.txt, LICENSES/BSD-3-Clause.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.22"
NEOTERM_PKG_SRCURL=https://github.com/MusicPlayerDaemon/libmpdclient/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=56bbae543a8a70db83b68c679b91990838f0db31a358c1a139774cd8ba7e3c59
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_BREAKS="libmpdclient-dev"
NEOTERM_PKG_REPLACES="libmpdclient-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-Ddefault_socket=${NEOTERM_PREFIX}/var/run/mpd.socket"

neoterm_step_pre_configure() {
	export NEOTERM_MESON_ENABLE_SOVERSION=1
}

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _GUARD_FILE="lib/libmpdclient.so.2"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
