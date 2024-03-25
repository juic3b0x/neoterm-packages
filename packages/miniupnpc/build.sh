NEOTERM_PKG_HOMEPAGE=https://miniupnp.tuxfamily.org/
NEOTERM_PKG_DESCRIPTION="Small UPnP client library and tool to access Internet Gateway Devices"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.2.6
NEOTERM_PKG_SRCURL=https://miniupnp.tuxfamily.org/files/miniupnpc-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=37fcd91953508c3e62d6964bb8ffbc5d47f3e13481fa54e6214fcc68704c66f1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="miniupnpc-dev"
NEOTERM_PKG_REPLACES="miniupnpc-dev"

neoterm_step_post_make_install() {
	ln -sfT upnpc-static "$NEOTERM_PREFIX/bin/upnpc"
}

neoterm_step_post_massage() {
	local _EXTERNAL_IP="bin/external-ip.sh"
	if [ -f "${_EXTERNAL_IP}" ]; then
		chmod 0700 "${_EXTERNAL_IP}"
	fi
}
