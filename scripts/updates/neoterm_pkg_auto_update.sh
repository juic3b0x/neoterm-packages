# shellcheck shell=bash
neoterm_pkg_auto_update() {
	if [[ -n "${__CACHED_TAG:-}" ]]; then
		neoterm_pkg_upgrade_version ${__CACHED_TAG}
		return $?
	fi
	
	local project_host
	project_host="$(echo "${NEOTERM_PKG_SRCURL}" | cut -d"/" -f3)"

	if [[ -z "${NEOTERM_PKG_UPDATE_METHOD}" ]]; then
		if [[ "${project_host}" == "github.com" ]]; then
			NEOTERM_PKG_UPDATE_METHOD="github"
		elif [[ "${project_host}" == "gitlab.com" ]]; then
			NEOTERM_PKG_UPDATE_METHOD="gitlab"
		else
			NEOTERM_PKG_UPDATE_METHOD="repology"
		fi
	fi

	local _err_msg="ERROR: source url's hostname is not ${NEOTERM_PKG_UPDATE_METHOD}.com, but has been
configured to use ${NEOTERM_PKG_UPDATE_METHOD}'s method."

	case "${NEOTERM_PKG_UPDATE_METHOD}" in
	github)
		if [[ "${project_host}" != "${NEOTERM_PKG_UPDATE_METHOD}.com" ]]; then
			neoterm_error_exit "${_err_msg}"
		else
			neoterm_github_auto_update
		fi
		;;
	gitlab)
		if [[ "${project_host}" != "${NEOTERM_PKG_UPDATE_METHOD}.com" ]]; then
			neoterm_error_exit "${_err_msg}"
		else
			neoterm_gitlab_auto_update
		fi
		;;
	repology)
		neoterm_repology_auto_update
		;;
	*)
		neoterm_error_exit <<-EndOfError
			ERROR: wrong value '${NEOTERM_PKG_UPDATE_METHOD}' for NEOTERM_PKG_UPDATE_METHOD.
			Can be 'github', 'gitlab' or 'repology'
		EndOfError
		;;
	esac
}
