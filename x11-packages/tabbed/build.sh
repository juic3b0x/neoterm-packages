NEOTERM_PKG_HOMEPAGE=https://tools.suckless.org/tabbed/
NEOTERM_PKG_DESCRIPTION="Generic tabbed interface"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7
NEOTERM_PKG_SRCURL=https://dl.suckless.org/tools/tabbed-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6e8682230a213d7dabf8a79306bd3ce023875b2295a9097db427d65c1c68f322
NEOTERM_PKG_DEPENDS="libx11, libxft"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	if [ ! -e ./xembed.1 ]; then
		cp $NEOTERM_PKG_BUILDER_DIR/xembed.1 ./
	fi
}
