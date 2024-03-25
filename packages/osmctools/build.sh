NEOTERM_PKG_HOMEPAGE=https://gitlab.com/osm-c-tools/osmctools
NEOTERM_PKG_DESCRIPTION="Simple tools for OpenStreetMap processing"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.9
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://gitlab.com/osm-c-tools/osmctools/-/archive/${NEOTERM_PKG_VERSION}/osmctools-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2f5298be5b4ba840a04f360c163849b34a31386ccd287657885e21268665f413
NEOTERM_PKG_DEPENDS="zlib"
NEOTERM_PKG_GROUPS="science"

neoterm_step_pre_configure () {
	autoreconf --install
}
