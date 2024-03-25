NEOTERM_PKG_HOMEPAGE=https://github.com/skeeto/passphrase2pgp
NEOTERM_PKG_DESCRIPTION="Generate EdDSA/cv25519 private key in GnuPG/SSH format reproducibly per hash of user given passphrase"
NEOTERM_PKG_LICENSE="Unlicense"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.0"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/skeeto/passphrase2pgp/releases/download/v$NEOTERM_PKG_VERSION/passphrase2pgp-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=dfed400dc3c5d5547a117dc91cc068bc1613daa0396089f6f66a51190b9889d7
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	mkdir bin
	go build -o ./bin -trimpath
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin bin/*
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME README.*
}
