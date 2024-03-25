NEOTERM_PKG_HOMEPAGE=https://github.com/go-jira/jira
NEOTERM_PKG_DESCRIPTION="Simple jira command line client written in Go"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.28
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/go-jira/jira/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=179abe90458281175a482cbd2e1ad662bdf563ef5acfc2cadf215ae32e0bd1e6
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin jira

	install -Dm644 /dev/null $NEOTERM_PREFIX/share/bash-completion/completions/jira-go
	install -Dm644 /dev/null $NEOTERM_PREFIX/share/zsh/site-functions/_jira_go
}

neoterm_step_create_debscripts() {
	cat <<- EOF > postinst
		#!$NEOTERM_PREFIX/bin/sh
		# \`|| true\` is used since jira exits with non-zero code even if request succeedes.
		jira --completion-script-bash > $NEOTERM_PREFIX/share/bash-completion/completions/jira-go || true
		jira --completion-script-zsh > $NEOTERM_PREFIX/share/zsh/site-functions/_jira_go || true
	EOF
}
