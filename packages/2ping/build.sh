NEOTERM_PKG_HOMEPAGE=https://www.finnie.org/software/2ping/
NEOTERM_PKG_DESCRIPTION="A bi-directional ping utility"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.5.1
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/rfinnie/2ping/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0f85dc21be1266daccfbba903819ca8935ebdbe002b1e0305bfda258af44fdcd
NEOTERM_PKG_DEPENDS="python"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"

neoterm_step_post_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man1 doc/2ping.1
}
