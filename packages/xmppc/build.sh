NEOTERM_PKG_HOMEPAGE=https://codeberg.org/Anoxinon_e.V./xmppc
NEOTERM_PKG_DESCRIPTION="Command Line Interface Tool for XMPP"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="j.r <j.r@jugendhacker.de>"
NEOTERM_PKG_VERSION=0.1.2
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://codeberg.org/Anoxinon_e.V./xmppc/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=05259ec5cba25f693edfe01389a3405835404539c7817fb208c201e29480e6b7
NEOTERM_PKG_DEPENDS="libstrophe, glib, gpgme"

neoterm_step_pre_configure() {
	./bootstrap.sh
}
