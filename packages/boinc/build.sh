TERMUX_PKG_HOMEPAGE=https://boinc.berkeley.edu/
TERMUX_PKG_DESCRIPTION="Open-source software for volunteer computing"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=7
_MINOR_VERSION=24
TERMUX_PKG_VERSION="7.24.3"
TERMUX_PKG_SRCURL=https://github.com/BOINC/boinc/archive/client_release/${_MAJOR_VERSION}.${_MINOR_VERSION}/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=1d8faa4de332cf6c74fcde842bc70d0477e42f8b11205de4bfe04512b6b6ff18
TERMUX_PKG_DEPENDS="libandroid-execinfo, libandroid-shmem, libc++, libcurl, openssl, zlib"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-manager
--disable-server
"

# etc/boinc-client.conf is not for Android, extra hooks needed to work
TERMUX_PKG_RM_AFTER_INSTALL="
etc/boinc-client.conf
"

termux_pkg_auto_update() {
	local api_url="https://api.github.com/repos/BOINC/boinc/git/refs/tags"
	local latest_refs_tags=$(curl -s "${api_url}" | jq .[].ref | sed -ne "s|.*client_release.*/\(.*\)\"|\1|p")
	if [[ -z "${latest_refs_tags}" ]]; then
		echo "WARN: Unable to get latest refs tags from upstream. Try again later." >&2
		return
	fi

	local latest_version=$(echo "${latest_refs_tags}" | tail -n1)
	if [[ "${latest_version}" == "${TERMUX_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${TERMUX_PKG_VERSION}'."
		return
	fi

	if ! dpkg --compare-versions "${latest_version}" gt "${TERMUX_PKG_VERSION}"; then
		termux_error_exit "
		ERROR: Resulting latest version is not counted as an update!
		Latest version =  ${latest_version}
		Current version = ${TERMUX_PKG_VERSION}
		"
	fi

	local major_version=$(echo "${latest_version}" | sed -E "s|([0-9]+).([0-9]+).([0-9]+)|\1|")
	local minor_version=$(echo "${latest_version}" | sed -E "s|([0-9]+).([0-9]+).([0-9]+)|\2|")
	sed -i "${TERMUX_PKG_BUILDER_DIR}/build.sh" \
		-e "s|^_MAJOR_VERSION=.*|_MAJOR_VERSION=${major_version}|" \
		-e "s|^_MINOR_VERSION=.*|_MINOR_VERSION=${minor_version}|"

	termux_pkg_upgrade_version "${latest_version}" --skip-version-check
}

termux_step_pre_configure() {
	export CFLAGS+=" -fPIC"
	export CXXFLAGS+=" -fPIC"
	export LDFLAGS+=" -landroid-execinfo -landroid-shmem $(${CC} -print-libgcc-file-name)"
	./_autosetup
}

termux_step_post_make_install() {
	install -Dm644 "${TERMUX_PKG_SRCDIR}/client/scripts/boinc.bash" "${TERMUX_PREFIX}/share/bash-completion/completions/boinc"
}
