NEOTERM_PKG_HOMEPAGE=https://mikefarah.gitbook.io/yq/
NEOTERM_PKG_DESCRIPTION="A lightweight and portable command-line YAML, JSON and XML processor"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.42.1"
NEOTERM_PKG_SRCURL=https://github.com/mikefarah/yq/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=be31e5e828a0251721ea71964596832d4a40cbc21c8a8392a804bc8d1c55dd62
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin yq
}
