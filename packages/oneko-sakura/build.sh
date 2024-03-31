NEOTERM_PKG_HOMEPAGE=http://www.daidouji.com/oneko
NEOTERM_PKG_DESCRIPTION="oneko-sakurais modified version of oneko, KINOMOTO Sakura chases around your mouse cursor"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.2.sakura.6"
NEOTERM_PKG_SRCURL=git+https://github.com/tie/oneko
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="libx11,libxext,xorgproto"
NEOTERM_CMAKE_BUILD="Unix Makefiles"
NEOTERM_PKG_GROUPS="games"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin "$NEOTERM_PKG_SRCDIR"/oneko
}
