NEOTERM_PKG_HOMEPAGE=https://github.com/bttger/markdown-flashcards
NEOTERM_PKG_DESCRIPTION="Small CLI app to learn with flashcards and spaced repetition"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.0.0"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/bttger/markdown-flashcards/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b0548f87b67b5421fadf1c83533e7ee98506df26b6a529be7b042747248ab201
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build -o mdfc ./cmd
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin mdfc
}
