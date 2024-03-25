NEOTERM_PKG_HOMEPAGE=https://github.com/rust-lang/rust-analyzer
NEOTERM_PKG_DESCRIPTION="A Rust compiler front-end for IDEs"
NEOTERM_PKG_LICENSE="Apache-2.0, MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="20240311"
_VERSION=${NEOTERM_PKG_VERSION:0:4}-${NEOTERM_PKG_VERSION:4:2}-${NEOTERM_PKG_VERSION:6:2}
NEOTERM_PKG_SRCURL=https://github.com/rust-lang/rust-analyzer/archive/refs/tags/${_VERSION}.tar.gz
NEOTERM_PKG_SHA256=31df3464840a79ad9303a2df9abb12f46d555e210112e80faa5ab665a8fb7202
NEOTERM_PKG_DEPENDS="rust-src"
NEOTERM_PKG_ANTI_BUILD_DEPENDS="rust-src"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_pkg_auto_update() {
	local e=0
	local api_url="https://api.github.com/repos/rust-lang/rust-analyzer/tags"
	local api_url_r=$(curl -s "${api_url}")
	local r1=$(echo "${api_url_r}" | jq .[].name | sed -e 's|\"||g')
	local latest_tag=$(echo "${r1}" | sed -nE 's/^([0-9]*-)/\1/p' | sort | tail -n1)
	# https://github.com/juic3b0x/neoterm-packages/issues/18667
	local latest_version=${latest_tag:0:4}${latest_tag:5:2}${latest_tag:8:2}
	if [[ "${latest_version}" == "${NEOTERM_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${NEOTERM_PKG_VERSION}'."
		return
	fi
	[[ -z "${api_url_r}" ]] && e=1
	[[ -z "${r1}" ]] && e=1
	[[ -z "${latest_tag}" ]] && e=1
	[[ -z "${latest_version}" ]] && e=1

	if [[ "${e}" != 0 ]]; then
		cat <<- EOL >&2
		WARN: Auto update failure!
		api_url_r=${api_url_r}
		r1=${r1}
		latest_tag=${latest_tag}
		latest_version=${latest_version}
		EOL
		return
	fi

	if ! dpkg --compare-versions "${latest_version}" gt "${NEOTERM_PKG_VERSION}"; then
		neoterm_error_exit "
		ERROR: Resulting latest version is not counted as an update!
		Latest version  = ${latest_version}
		Current version = ${NEOTERM_PKG_VERSION}
		"
	fi

	neoterm_pkg_upgrade_version "${latest_version}" --skip-version-check
}

neoterm_step_pre_configure() {
	neoterm_setup_rust
}

neoterm_step_make() {
	cargo build --jobs "${NEOTERM_MAKE_PROCESSES}" --target "${CARGO_TARGET_NAME}" --release
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}/bin" "target/${CARGO_TARGET_NAME}/release/rust-analyzer"
}
