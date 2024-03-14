NEOTERM_PKG_HOMEPAGE=https://github.com/42wim/matterircd
NEOTERM_PKG_DESCRIPTION="Connect to your mattermost or slack using your IRC-client of choice"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.28.0"
NEOTERM_PKG_SRCURL=https://github.com/42wim/matterircd/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a23a1ac6a5dda8aa0a25261b6a5ce1084b63b626fe65cb94e8581c8bb0482c64
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin "$NEOTERM_PKG_SRCDIR"/matterircd
}
