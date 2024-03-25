NEOTERM_PKG_HOMEPAGE=https://gitlab.com/gitlab-org/cli
NEOTERM_PKG_DESCRIPTION="A GitLab CLI tool bringing GitLab to your command line"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.37.0"
NEOTERM_PKG_SRCURL=https://gitlab.com/gitlab-org/cli/-/archive/v${NEOTERM_PKG_VERSION}/cli-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=d70e9a64fa7cff7375573e37fa74dc177244ed733ce6fc0c4d00a06bbd8fdf6a
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="GLAB_VERSION=${NEOTERM_PKG_VERSION}"

neoterm_step_pre_configure() {
	neoterm_setup_golang
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin bin/glab

	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/bash-completion/completions/glab.bash
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/zsh/site-functions/_glab
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/fish/vendor_completions.d/glab.fish
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		glab completion -s bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/glab.bash
		glab completion -s zsh > ${NEOTERM_PREFIX}/share/zsh/site-functions/_glab
		glab completion -s fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/glab.fish
	EOF
}
