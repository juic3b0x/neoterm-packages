NEOTERM_PKG_HOMEPAGE=https://await-cli.app/
NEOTERM_PKG_DESCRIPTION="Runs list of commands in parallel and waits for their termination"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.999
NEOTERM_PKG_SRCURL=https://github.com/slavaGanzin/await/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=65e96c82f52786807282172b1d4b25890c521e4f9ba9998251e8da3c5a61a11a
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	$CC $CPPFLAGS $CFLAGS "$NEOTERM_PKG_SRCDIR"/await.c -o await $LDFLAGS
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin await
}
