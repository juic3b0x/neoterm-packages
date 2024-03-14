NEOTERM_PKG_HOMEPAGE=https://bombadillo.colorfield.space/
NEOTERM_PKG_DESCRIPTION="A non-web client for the terminal, supporting Gopher, Gemini and much more"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.4.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/b/bombadillo/bombadillo_${NEOTERM_PKG_VERSION}.orig.tar.gz
NEOTERM_PKG_SHA256=d52a753e7a77c5ab486f536a7c488e61c68a8c11a5e455143d281b3d8306afa0
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin bombadillo
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man1 \
		$NEOTERM_PKG_SRCDIR/bombadillo.1
}
