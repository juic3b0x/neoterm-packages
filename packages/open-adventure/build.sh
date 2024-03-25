NEOTERM_PKG_HOMEPAGE=http://www.catb.org/~esr/open-adventure/
NEOTERM_PKG_DESCRIPTION="Forward-port of the original Colossal Cave Adventure from 1976-77"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION="1.18"
NEOTERM_PKG_SRCURL=https://gitlab.com/esr/open-adventure/-/archive/${NEOTERM_PKG_VERSION}/open-adventure-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=30c48f7e8ec05e58acba393f2e62cca83418c71788db8827c7d5acefbe1a76fc
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libedit"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_GROUPS="games"

neoterm_step_make_install () {
	install -m 0755 advent $NEOTERM_PREFIX/bin
}
