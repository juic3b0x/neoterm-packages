NEOTERM_PKG_HOMEPAGE=https://ptitseb.github.io/box86/
NEOTERM_PKG_DESCRIPTION="Linux Userspace x86 Emulator"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=ed3296978ebeee19009b7bd78ea6219cf9996611
_COMMIT_DATE=20230402
_COMMIT_TIME=164444
NEOTERM_PKG_VERSION="0.3.0.20230402.164444ged329697"
NEOTERM_PKG_SRCURL=git+https://github.com/ptitSeb/box86
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="libandroid-complex-math, libandroid-glob, libandroid-spawn, libandroid-sysv-semaphore"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_ENABLE_CLANG16_PORTING=false

# box86 is for arm only
NEOTERM_PKG_BLACKLISTED_ARCHES="aarch64, i686, x86_64"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID=ON
-DARM_DYNAREC=ON
"

# this should only be used until release new version
neoterm_pkg_auto_update() {
	local latest_commit=$(curl -s https://api.github.com/repos/ptitSeb/box86/commits | jq .[].sha | head -1 | sed -e 's|\"||g')
	if [[ -z "${latest_commit}" ]]; then
		echo "WARN: Unable to get latest commit from upstream. Try again later." >&2
		return 0
	fi

	if [[ "${latest_commit}" == "${_COMMIT}" ]]; then
		echo "INFO: No update needed. Already at version '${NEOTERM_PKG_VERSION}'."
		return 0
	fi

	local latest_commit_date_tz=$(curl -s "https://api.github.com/repos/ptitSeb/box86/commits/${latest_commit}" | jq .commit.committer.date | sed -e 's|\"||g')
	if [[ -z "${latest_commit_date_tz}" ]]; then
		neoterm_error_exit "ERROR: Unable to get latest commit date info"
	fi

	local latest_commit_date=$(echo "${latest_commit_date_tz}" | sed -e 's|\(.*\)T\(.*\)Z|\1|' -e 's|\-||g')
	local latest_commit_time=$(echo "${latest_commit_date_tz}" | sed -e 's|\(.*\)T\(.*\)Z|\2|' -e 's|\:||g')

	# https://github.com/juic3b0x/neoterm-packages/issues/11827
	# really fix it by including longer date time info into versioning
	# always check this in case upstream change the version format
	local latest_version="0.3.0.${latest_commit_date}.${latest_commit_time}g${latest_commit:0:8}"

	local current_date_epoch=$(date "+%s")
	local _COMMIT_DATE_epoch=$(date -d "${_COMMIT_DATE}" "+%s")
	local current_date_diff=$(((current_date_epoch-_COMMIT_DATE_epoch)/(60*60*24)))
	if [[ "${current_date_diff}" -lt 7 ]]; then
		echo "INFO: Queuing updates after 7 days since last push, currently its ${current_date_diff}"
		return 0
	fi

	if ! dpkg --compare-versions "${latest_version}" gt "${NEOTERM_PKG_VERSION}"; then
		neoterm_error_exit "ERROR: Resulting latest version is not counted as update to the current version (${latest_version} < ${NEOTERM_PKG_VERSION})"
	fi

	# unlikely to happen
	if [[ "${latest_commit_date}" -lt "${_COMMIT_DATE}" ]]; then
		neoterm_error_exit "ERROR: Upstream is older than current package version. Please report to upstream."
	elif [[ "${latest_commit_date}" -eq "${_COMMIT_DATE}" ]] && [[ "${latest_commit_time}" -lt "${_COMMIT_TIME}" ]]; then
		neoterm_error_exit "ERROR: Upstream is older than current package version. Please report to upstream."
	fi

	sed -i "${NEOTERM_PKG_BUILDER_DIR}/build.sh" \
		-e "s|^_COMMIT=.*|_COMMIT=${latest_commit}|" \
		-e "s|^_COMMIT_DATE=.*|_COMMIT_DATE=${latest_commit_date}|" \
		-e "s|^_COMMIT_TIME=.*|_COMMIT_TIME=${latest_commit_time}|"

	# maybe save a few ms as we already done version check
	neoterm_pkg_upgrade_version "${latest_version}" --skip-version-check
}

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout "${_COMMIT}"
}

neoterm_step_pre_configure() {
	export CFLAGS="${CFLAGS/-Oz/-O2} -flto"
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}/bin" "${NEOTERM_PKG_BUILDDIR}/box86"
}

