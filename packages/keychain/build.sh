NEOTERM_PKG_HOMEPAGE=https://www.funtoo.org/Keychain
NEOTERM_PKG_DESCRIPTION="keychain ssh-agent front-end"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.8.5
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/funtoo/keychain/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=dcce703e5001211c8ebc0528f45b523f84d2bceeb240600795b4d80cb8475a0b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="dash, gnupg"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	sed -iE "s@^PATH=.*@PATH=$NEOTERM_PREFIX/bin@" keychain
	install -Dm700 keychain "${NEOTERM_PREFIX}"/bin/keychain
	install -Dm600 keychain.1 "${NEOTERM_PREFIX}"/share/man/man1/keychain.1
}
