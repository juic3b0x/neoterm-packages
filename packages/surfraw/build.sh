NEOTERM_PKG_HOMEPAGE=https://gitlab.com/surfraw/Surfraw
NEOTERM_PKG_DESCRIPTION="Shell Users' Revolutionary Front Rage Against the Web"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.3.0
NEOTERM_PKG_REVISION=10
NEOTERM_PKG_SRCURL=https://gitlab.com/surfraw/Surfraw/-/archive/surfraw-${NEOTERM_PKG_VERSION}/Surfraw-surfraw-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b5e2b451a822ed437b165a5c81d8448570ee590db902fcd8174d6c51fcc4a16d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/.*-//'
NEOTERM_PKG_DEPENDS="lynx, perl"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	./prebuild
}
