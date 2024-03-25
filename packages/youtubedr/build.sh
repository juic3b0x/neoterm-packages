NEOTERM_PKG_HOMEPAGE=https://github.com/kkdai/youtube
NEOTERM_PKG_DESCRIPTION="Download youtube video in Golang"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION="2.10.1"
NEOTERM_PKG_SRCURL=https://github.com/kkdai/youtube/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9d71c4a7e192d81f12944b3c881fa7d61a20d48d083bfad72bd357f9becb04ef
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	cd "$NEOTERM_PKG_SRCDIR"
	export GOPATH="${NEOTERM_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/kkdai/"
	cp -a "${NEOTERM_PKG_SRCDIR}" "${GOPATH}/src/github.com/kkdai/youtube"
	cd "${GOPATH}/src/github.com/kkdai/youtube/"
	go get -d -v
	cd cmd/youtubedr
	go build .
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin "$GOPATH"/src/github.com/kkdai/youtube/cmd/youtubedr/youtubedr

	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/bash-completion/completions/youtubedr
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/zsh/site-functions/_youtubedr
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/fish/vendor_completions.d/youtubedr.fish
}

neoterm_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		youtubedr completion bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/youtubedr
		youtubedr completion zsh > ${NEOTERM_PREFIX}/share/zsh/site-functions/_youtubedr
		youtubedr completion fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/youtubedr.fish
	EOF
}
