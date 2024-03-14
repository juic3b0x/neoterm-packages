NEOTERM_PKG_HOMEPAGE=https://eternalterminal.dev
NEOTERM_PKG_DESCRIPTION="A remote shell that automatically reconnects without interrupting the session"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="6.2.8"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=git+https://github.com/MisterTea/EternalTerminal
NEOTERM_PKG_GIT_BRANCH=et-v${NEOTERM_PKG_VERSION}
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="libc++, libsodium, openssl, protobuf, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DDISABLE_VCPKG=1"

neoterm_step_pre_configure() {
	neoterm_setup_protobuf
}

neoterm_step_post_make_install() {
	install -Dm600 $NEOTERM_PKG_SRCDIR/etc/et.cfg $NEOTERM_PREFIX/etc/
}
