NEOTERM_PKG_HOMEPAGE=https://github.com/topgrade-rs/topgrade/
NEOTERM_PKG_DESCRIPTION="Upgrade all the things"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@laurentlbm"
NEOTERM_PKG_VERSION="14.0.1"
NEOTERM_PKG_SRCURL="https://github.com/topgrade-rs/topgrade/archive/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=e4262fae2c89efe889b5a3533dc25d35dd3fbaf373091170f20bcc852017e8be
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	rm -f pyproject.toml
}

neoterm_step_post_massage() {
	mkdir -p ./share/bash-completion/completions
	mkdir -p ./share/zsh/site-functions
	mkdir -p ./share/fish/vendor_completions.d
	mkdir -p ./share/man/man1
}

neoterm_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		${NEOTERM_PREFIX}/bin/topgrade --gen-completion bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/topgrade
		${NEOTERM_PREFIX}/bin/topgrade --gen-completion zsh > ${NEOTERM_PREFIX}/share/zsh/site-functions/_topgrade
		${NEOTERM_PREFIX}/bin/topgrade --gen-completion fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/topgrade.fish
		${NEOTERM_PREFIX}/bin/topgrade --gen-manpage > ${NEOTERM_PREFIX}/share/man/man1/topgrade.1
		exit 0
	EOF
	cat <<-EOF > ./prerm
		#!${NEOTERM_PREFIX}/bin/sh
		rm -f ${NEOTERM_PREFIX}/share/bash-completion/completions/topgrade
		rm -f ${NEOTERM_PREFIX}/share/zsh/site-functions/_topgrade
		rm -f ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/topgrade.fish
		rm -f ${NEOTERM_PREFIX}/share/man/man1/topgrade.1
		exit 0
	EOF
}
