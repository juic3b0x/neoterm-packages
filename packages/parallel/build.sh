NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/parallel/
NEOTERM_PKG_DESCRIPTION="GNU Parallel is a shell tool for executing jobs in parallel using one or more machines"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="20240222"
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/parallel/parallel-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=eba09b6a7e238f622293f7d461597f35075cb56f170d0a73148f53d259ec8556
NEOTERM_PKG_DEPENDS="perl"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_pkg_auto_update() {
	local e=0
	local api_url="https://mirrors.kernel.org/gnu/parallel"
	local api_url_r=$(curl -s "${api_url}/")
	local r1=$(echo "${api_url_r}" | sed -nE 's|<.*>parallel-(.*).tar.bz2<.*>.*|\1|p')
	local latest_version=$(echo "${r1}" | sed -nE 's|([0-9]+)|\1|p' | tail -n1)
	if [[ "${latest_version}" == "${NEOTERM_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${NEOTERM_PKG_VERSION}'."
		return
	fi
	[[ -z "${api_url_r}" ]] && e=1
	[[ -z "${r1}" ]] && e=1
	[[ -z "${latest_version}" ]] && e=1

	if [[ "${e}" != 0 ]]; then
		cat <<- EOL >&2
		WARN: Auto update failure!
		api_url_r=${api_url_r}
		r1=${r1}
		latest_version=${latest_version}
		EOL
		return
	fi

	local latest_tbz="${api_url}/parallel-latest.tar.bz2"
	local tmpdir=$(mktemp -d)
	curl -so "${tmpdir}/parallel-latest.tar.bz2" "${latest_tbz}"
	tar -xf "${tmpdir}/parallel-latest.tar.bz2" -C "${tmpdir}"
	if [[ ! -d "${tmpdir}/parallel-${latest_version}" ]]; then
		neoterm_error_exit "
		ERROR: Latest archive does not contain latest version
		$(ls -l "${tmpdir}")
		"
	fi

	rm -fr "${tmpdir}"

	neoterm_pkg_upgrade_version "${latest_version}"
}

neoterm_step_post_make_install() {
	install -Dm644 /dev/null "${NEOTERM_PREFIX}"/share/bash-completion/completions/parallel

	mkdir -p "${NEOTERM_PREFIX}"/share/zsh/site-functions
	cat <<- EOF > "${NEOTERM_PREFIX}"/share/zsh/site-functions/_parallel
	#compdef parallel
	(( $+functions[_comp_parallel] )) ||
	eval "\$(parallel --shell-completion auto)" &&
	comp_parallel
	EOF
}

neoterm_step_create_debscripts() {
	cat <<- EOF > postinst
	#!${NEOTERM_PREFIX}/bin/sh
	parallel --shell-completion bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/parallel
	EOF
}
