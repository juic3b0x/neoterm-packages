# shellcheck shell=bash
neoterm_pkg_upgrade_version() {
	if [[ "$#" -lt 1 ]]; then
		neoterm_error_exit <<-EndUsage
			Usage: ${FUNCNAME[0]} LATEST_VERSION [--skip-version-check]
		EndUsage
	fi

	local LATEST_VERSION="$1"
	local SKIP_VERSION_CHECK="${2:-}"
	local EPOCH
	EPOCH="${NEOTERM_PKG_VERSION%%:*}" # If there is no epoch, this will be the full version.
	# Check if it isn't the full version and add ':'.
	if [[ "${EPOCH}" != "${NEOTERM_PKG_VERSION}" ]]; then
		EPOCH="${EPOCH}:"
	else
		EPOCH=""
	fi

	# If needed, filter version numbers using grep regexp.
	if [[ -n "${NEOTERM_PKG_UPDATE_VERSION_REGEXP}" ]]; then
		# Extract version numbers.
		local OLD_LATEST_VERSION="${LATEST_VERSION}"
		LATEST_VERSION="$(grep -oP "${NEOTERM_PKG_UPDATE_VERSION_REGEXP}" <<< "${LATEST_VERSION}" || true)"
		if [[ -z "${LATEST_VERSION}" ]]; then
			neoterm_error_exit <<-EndOfError
				ERROR: failed to filter version numbers using regexp '${NEOTERM_PKG_UPDATE_VERSION_REGEXP}'.
				Ensure that it is works correctly with ${OLD_LATEST_VERSION}.
			EndOfError
		fi
		unset OLD_LATEST_VERSION
	fi

	# If needed, filter version numbers using sed regexp.
	if [[ -n "${NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP}" ]]; then
		# Extract version numbers.
		local OLD_LATEST_VERSION="${LATEST_VERSION}"
		LATEST_VERSION="$(sed "${NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP}" <<< "${LATEST_VERSION}" || true)"
		if [[ -z "${LATEST_VERSION}" ]]; then
			neoterm_error_exit <<-EndOfError
				ERROR: failed to filter version numbers using regexp '${NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP}'.
				Ensure that it is works correctly with ${OLD_LATEST_VERSION}.
			EndOfError
		fi
		unset OLD_LATEST_VERSION
	fi

	# Translate "_" into ".": some packages use underscores to seperate
	# version numbers, but we require them to be separated by dots.
	LATEST_VERSION="${LATEST_VERSION//_/.}"

	if [[ "${SKIP_VERSION_CHECK}" != "--skip-version-check" ]]; then
		if ! neoterm_pkg_is_update_needed \
			"${NEOTERM_PKG_VERSION#*:}" "${LATEST_VERSION}"; then
			echo "INFO: No update needed. Already at version '${LATEST_VERSION}'."
			return 0
		fi
	fi
	
	if [[ -n "${NEOTERM_PKG_UPGRADE_VERSION_DRY_RUN:-}" ]]; then
		return 1
	fi

	if [[ "${BUILD_PACKAGES}" == "false" ]]; then
		echo "INFO: package needs to be updated to ${LATEST_VERSION}."
	else
		echo "INFO: package being updated to ${LATEST_VERSION}."

		sed -i \
			"s/^\(NEOTERM_PKG_VERSION=\)\(.*\)\$/\1\"${EPOCH}${LATEST_VERSION}\"/g" \
			"${NEOTERM_PKG_BUILDER_DIR}/build.sh"
		sed -i \
			"/NEOTERM_PKG_REVISION=/d" \
			"${NEOTERM_PKG_BUILDER_DIR}/build.sh"

		# Update checksum
		if [[ "${NEOTERM_PKG_SHA256[*]}" != "SKIP_CHECKSUM" ]] && [[ "${NEOTERM_PKG_SRCURL:0:4}" != "git+" ]]; then
			echo n | "${NEOTERM_SCRIPTDIR}/scripts/bin/update-checksum" "${NEOTERM_PKG_NAME}" || {
				git checkout -- "${NEOTERM_PKG_BUILDER_DIR}"
				git pull --rebase
				neoterm_error_exit "ERROR: failed to update checksum."
			}
		fi

		echo "INFO: Trying to build package."

		for repo_path in $(jq --raw-output 'del(.pkg_format) | keys | .[]' ${NEOTERM_SCRIPTDIR}/repo.json); do
			_buildsh_path="${NEOTERM_SCRIPTDIR}/${repo_path}/${NEOTERM_PKG_NAME}/build.sh"
			repo=$(jq --raw-output ".\"${repo_path}\".name" ${NEOTERM_SCRIPTDIR}/repo.json)
			repo=${repo#"neoterm-"}

			if [ -f "${_buildsh_path}" ]; then
				echo "INFO: Package ${NEOTERM_PKG_NAME} exists in ${repo} repo."
				unset _buildsh_path repo_path
				break
			fi
		done

		if "${NEOTERM_SCRIPTDIR}/scripts/run-docker.sh" ./build-package.sh -a "${NEOTERM_ARCH}" -i "${NEOTERM_PKG_NAME}"; then
			if [[ "${GIT_COMMIT_PACKAGES}" == "true" ]]; then
				echo "INFO: Committing package."
				stderr="$(
					git add "${NEOTERM_PKG_BUILDER_DIR}" 2>&1 >/dev/null
					git commit -m "bump(${repo}/${NEOTERM_PKG_NAME}): ${LATEST_VERSION}" \
						-m "This commit has been automatically submitted by Github Actions." 2>&1 >/dev/null
				)" || {
					neoterm_error_exit <<-EndOfError
						ERROR: git commit failed. See below for details.
						${stderr}
					EndOfError
				}
			fi

			if [[ "${GIT_PUSH_PACKAGES}" == "true" ]]; then
				echo "INFO: Pushing package."
				stderr="$(
					git pull --rebase 2>&1 >/dev/null
					git push 2>&1 >/dev/null
				)" || {
					neoterm_error_exit <<-EndOfError
						ERROR: git push failed. See below for details.
						${stderr}
					EndOfError
				}
			fi
		else
			git checkout -- "${NEOTERM_PKG_BUILDER_DIR}"
			neoterm_error_exit "ERROR: failed to build."
		fi

	fi
}
