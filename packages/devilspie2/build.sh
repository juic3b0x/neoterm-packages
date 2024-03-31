NEOTERM_PKG_HOMEPAGE=https://www.nongnu.org/devilspie2/
NEOTERM_PKG_DESCRIPTION="A window-matching utility"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.44
NEOTERM_PKG_SRCURL=https://download.savannah.nongnu.org/releases/devilspie2/devilspie2-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=0a9f1eadd2b22a318163e4180065d495221ba1a43ad2021ea6866cd118042640
NEOTERM_PKG_DEPENDS="glib, gtk3, liblua54, libwnck, libx11, libxinerama"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="LUA=lua54"

neoterm_step_post_configure() {
	mkdir -p obj
}
