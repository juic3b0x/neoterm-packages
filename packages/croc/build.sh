NEOTERM_PKG_HOMEPAGE=https://github.com/schollz/croc
NEOTERM_PKG_DESCRIPTION="Easily and securely send things from one computer to another"
NEOTERM_PKG_LICENSE=MIT
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="9.6.14"
NEOTERM_PKG_SRCURL=https://github.com/schollz/croc/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c8b1a109fcf496a103b8d70ef76c0ace6ef22d5575be6bbe2f571c6b1fe6a8ac
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	cd $NEOTERM_PKG_SRCDIR

	neoterm_setup_golang

	go build -o croc -trimpath
}

neoterm_step_make_install() {
	install -m755 croc $NEOTERM_PREFIX/bin/croc
}
