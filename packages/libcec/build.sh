NEOTERM_PKG_HOMEPAGE=http://libcec.pulse-eight.com/
NEOTERM_PKG_DESCRIPTION="Provides support for Pulse-Eight's USB-CEC adapter and other CEC capable hardware"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=6.0.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/Pulse-Eight/libcec/archive/libcec-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=090696d7a4fb772d7acebbb06f91ab92e025531c7c91824046b9e4e71ecb3377
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="libc++, libp8-platform"

neoterm_step_post_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man1 \
		$NEOTERM_PKG_SRCDIR/debian/cec-client.1
}
