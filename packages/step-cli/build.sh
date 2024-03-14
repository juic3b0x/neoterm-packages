NEOTERM_PKG_HOMEPAGE=https://smallstep.com/cli
NEOTERM_PKG_DESCRIPTION="An easy-to-use CLI tool for building, operating, and automating Public Key Infrastructure (PKI) systems and workflows"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.25.2"
NEOTERM_PKG_SRCURL=https://github.com/smallstep/cli/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=088bcd694bcfb16fd3482ba369f984a2423ef8410564e377e12284d91c3a7cb1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang

	local _DATE=$(date -u '+%Y-%m-%d %H:%M UTC')
	go build -v -ldflags "-X \"main.Version=$NEOTERM_PKG_VERSION\" -X \"main.BuildTime=$_DATE\"" \
		./cmd/step
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin step
}


neoterm_step_post_massage() {
	mkdir -p ./share/bash-completion/completions
	mkdir -p ./share/zsh/site-functions
	mkdir -p ./share/fish/vendor_completions.d
}

neoterm_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		${NEOTERM_PREFIX}/bin/step completion bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/step
		${NEOTERM_PREFIX}/bin/step completion zsh > ${NEOTERM_PREFIX}/share/zsh/site-functions/_step
		${NEOTERM_PREFIX}/bin/step completion fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/step.fish
		exit 0
	EOF
	cat <<-EOF > ./prerm
		#!${NEOTERM_PREFIX}/bin/sh
		rm -f ${NEOTERM_PREFIX}/share/bash-completion/completions/step
		rm -f ${NEOTERM_PREFIX}/share/zsh/site-functions/_step
		rm -f ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/step.fish
		exit 0
	EOF
}
