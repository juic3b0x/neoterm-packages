# shellcheck shell=bash
# Default algorithm to use for packages hosted on hosts using gitlab-ci.
neoterm_gitlab_auto_update() {
	local latest_tag
	latest_tag="$(
		neoterm_gitlab_api_get_tag \
			"${NEOTERM_PKG_SRCURL}" "${NEOTERM_PKG_UPDATE_TAG_TYPE}" "${NEOTERM_GITLAB_API_HOST}"
	)"
	if [[ -z "${latest_tag}" ]]; then
		neoterm_error_exit "ERROR: Unable to get tag from ${NEOTERM_PKG_SRCURL}"
	fi
	neoterm_pkg_upgrade_version "${latest_tag}"
}
