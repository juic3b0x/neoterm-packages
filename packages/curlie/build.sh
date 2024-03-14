NEOTERM_PKG_HOMEPAGE=https://curlie.io/
NEOTERM_PKG_DESCRIPTION="The power of curl, the ease of use of httpie"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.7.2"
NEOTERM_PKG_SRCURL=git+https://github.com/rs/curlie
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin curlie
}
