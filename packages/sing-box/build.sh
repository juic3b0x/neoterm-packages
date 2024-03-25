NEOTERM_PKG_HOMEPAGE=https://sing-box.sagernet.org
NEOTERM_PKG_DESCRIPTION="The universal proxy platform"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="kay9925@outlook.com"
NEOTERM_PKG_VERSION="1.8.8"
NEOTERM_PKG_SRCURL="https://github.com/SagerNet/sing-box/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=dfa64c1da309000998ff9c5fb35bac2795c9e88ce3c63ad47862ba6c3aeda74f
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	local tags="with_gvisor,with_quic,with_wireguard,with_utls,with_clash_api"
	local ldflags="\
	-w -s \
	-X 'github.com/sagernet/sing-box/constant.Version=${NEOTERM_PKG_VERSION}' \
	"

	export CGO_ENABLED=1

	go build \
		-trimpath \
		-tags "${tags}" \
		-ldflags="${ldflags}" \
		-o "${NEOTERM_PKG_NAME}" \
		./cmd/sing-box

}

neoterm_step_make_install() {
	install -Dm700 ./${NEOTERM_PKG_NAME} ${NEOTERM_PREFIX}/bin

	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/bash-completion/completions/sing-box.bash"
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/fish/vendor_completions.d/sing-box.fish"
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/zsh/site-functions/_sing-box"

}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		sing-box completion bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/sing-box.bash
		sing-box completion fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/sing-box.fish
		sing-box completion zsh > ${NEOTERM_PREFIX}/share/zsh/site-functions/_sing-box
	EOF
}
