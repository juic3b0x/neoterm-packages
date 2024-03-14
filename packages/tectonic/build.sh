NEOTERM_PKG_HOMEPAGE=https://tectonic-typesetting.github.io/
NEOTERM_PKG_DESCRIPTION="A modernized, complete, self-contained TeX/LaTeX engine"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.14.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/tectonic-typesetting/tectonic
NEOTERM_PKG_GIT_BRANCH=tectonic@${NEOTERM_PKG_VERSION}
NEOTERM_PKG_DEPENDS="fontconfig, freetype, libc++, libgraphite, libicu, libpng, openssl, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_pkg_auto_update() {
	# Get latest release tag:
	local api_url="https://api.github.com/repos/tectonic-typesetting/tectonic/git/refs/tags"
	local latest_refs_tags=$(curl -s "${api_url}" | jq .[].ref | sed -ne "s|.*tectonic@\(.*\)\"|\1|p")
	if [[ -z "${latest_refs_tags}" ]]; then
		echo "WARN: Unable to get latest refs tags from upstream. Try again later." >&2
		return
	fi

	local latest_version=$(echo "${latest_refs_tags}" | tail -n1)
	if [[ "${latest_version}" == "${NEOTERM_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${NEOTERM_PKG_VERSION}'."
		return
	fi

	neoterm_pkg_upgrade_version "${latest_version}"
}

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/tectonic
}
