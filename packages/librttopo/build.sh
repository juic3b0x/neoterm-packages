NEOTERM_PKG_HOMEPAGE=https://git.osgeo.org/gitea/rttopo/librttopo
NEOTERM_PKG_DESCRIPTION="The RT Topology Library exposes an API to create and manage standard topologies"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://git.osgeo.org/gitea/rttopo/librttopo/archive/librttopo-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2e2fcabb48193a712a6c76ac9a9be2a53f82e32f91a2bc834d9f1b4fa9cd879f
NEOTERM_PKG_DEPENDS="libgeos, proj"
NEOTERM_PKG_GROUPS="science"

neoterm_step_pre_configure() {
	./autogen.sh
}
