NEOTERM_PKG_HOMEPAGE=https://github.com/ayntgl/discordo
NEOTERM_PKG_DESCRIPTION="A lightweight, secure, and feature-rich Discord terminal client"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=05fb80f88970e310e5c93d0a68dbe7c32180ebac
NEOTERM_PKG_VERSION=2022.08.12
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=git+https://github.com/ayntgl/discordo
NEOTERM_PKG_GIT_BRANCH=main
NEOTERM_PKG_SHA256=2728f592186909e5f837aa5780594ba4d120eab20ab9be9b93622afcd169ba91
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="golang"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build -trimpath -buildmode=pie -ldflags "-s -w" .
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin "$NEOTERM_PKG_SRCDIR"/discordo
}
