NEOTERM_PKG_HOMEPAGE=http://www.gnustep.org
NEOTERM_PKG_DESCRIPTION="The GNUstep makefile package"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.9.1
NEOTERM_PKG_SRCURL=https://github.com/gnustep/tools-make/archive/make-${NEOTERM_PKG_VERSION//./_}.tar.gz
NEOTERM_PKG_SHA256=78ef0f68402c379979a9a46499ac308fe5c1512aa198138c87649ee611aedf41
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP='(?<=make-)\d+\_\d+\_\d+'
NEOTERM_PKG_DEPENDS="libobjc2"

neoterm_step_pre_configure() {
	export OBJCXX="$CXX"
}
