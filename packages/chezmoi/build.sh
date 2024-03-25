NEOTERM_PKG_HOMEPAGE=https://chezmoi.io
NEOTERM_PKG_DESCRIPTION="Manage your dotfiles across multiple machines"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION="2.47.1"
NEOTERM_PKG_SRCURL=https://github.com/twpayne/chezmoi/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0a87ab59bf9bb66b70e0711a4fe4b8c60cce431df089896db7e25324e8758523
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	cd "$NEOTERM_PKG_SRCDIR"

	mkdir -p "${NEOTERM_PKG_BUILDDIR}/src/github.com/twpayne"
	cp -a "${NEOTERM_PKG_SRCDIR}" "${NEOTERM_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi"
	cd "${NEOTERM_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi"

	go get -d -v
	go build -tags noupgrade,noembeddocs \
		-ldflags "-X github.com/twpayne/chezmoi/cmd.DocsDir=$NEOTERM_PREFIX/share/doc/chezmoi -X main.version=${NEOTERM_PKG_VERSION}" .
}

neoterm_step_make_install() {
	install -Dm700 ${NEOTERM_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi/chezmoi $NEOTERM_PREFIX/bin/chezmoi

	mkdir -p $NEOTERM_PREFIX/share/bash-completion/completions \
		$NEOTERM_PREFIX/share/fish/completions \
		$NEOTERM_PREFIX/share/zsh/site-functions \
		$NEOTERM_PREFIX/share/doc/chezmoi

	install -Dm600 ${NEOTERM_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi/completions/chezmoi-completion.bash \
		$NEOTERM_PREFIX/share/bash-completion/completions/chezmoi
	install -Dm600 ${NEOTERM_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi/completions/chezmoi.fish \
		$NEOTERM_PREFIX/share/fish/vendor_completions.d/chezmoi.fish
	install -Dm600 ${NEOTERM_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi/completions/chezmoi.zsh \
		$NEOTERM_PREFIX/share/zsh/site-functions/_chezmoi
}
