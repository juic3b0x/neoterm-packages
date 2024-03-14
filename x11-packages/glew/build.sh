NEOTERM_PKG_HOMEPAGE=https://glew.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="The OpenGL Extension Wrangler Library"
NEOTERM_PKG_LICENSE="BSD, GPL-2.0, MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.2.0
NEOTERM_PKG_REVISION=11
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/glew/glew-${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=d4fc82893cfb00109578d0a1a2337fb8ca335b3ceccf97b97e5cc7f08e4353e1
NEOTERM_PKG_DEPENDS="glu, libxi, libxmu"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LD=$CC
}
