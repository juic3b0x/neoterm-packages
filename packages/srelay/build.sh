NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/socks-relay
NEOTERM_PKG_DESCRIPTION="A Free SOCKS proxy server"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.4.8p3
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_SRCURL=http://downloads.sourceforge.net/sourceforge/socks-relay/srelay-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=efa38cb3e9e745a05ccb4b59fcf5d041184f15dbea8eb80c1b0ce809bb00c924
NEOTERM_PKG_DEPENDS="libcrypt"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_CONFFILES="
etc/srelay.conf
etc/srelay.passwd
"

neoterm_step_pre_configure() {
	autoreconf -fi

	export CPPFLAGS="${CPPFLAGS} -DLINUX"
}

neoterm_step_make_install() {
	install -Dm755 srelay "${NEOTERM_PREFIX}/bin/srelay"
	install -Dm644 srelay.conf "${NEOTERM_PREFIX}/etc/srelay.conf"
	install -Dm644 srelay.passwd "${NEOTERM_PREFIX}/etc/srelay.passwd"
	install -Dm644 srelay.8 "${NEOTERM_PREFIX}/share/man/man8/srelay.8"
}

neoterm_step_install_license() {
	install -Dm600 -t "$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME" \
		"$NEOTERM_PKG_BUILDER_DIR"/LICENSE.txt
}
