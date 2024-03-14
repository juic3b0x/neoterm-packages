NEOTERM_PKG_HOMEPAGE=https://www.yoctoproject.org/software-item/matchbox/
NEOTERM_PKG_DESCRIPTION="An on-screen virtual keyboard."
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1.1
NEOTERM_PKG_REVISION=30
NEOTERM_PKG_SRCURL=https://git.yoctoproject.org/matchbox-keyboard/snapshot/matchbox-keyboard-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=dd3e9494a9499a3bf3017c8c1e6572a4e91deb20e219717db17c0977750b8bcb
NEOTERM_PKG_DEPENDS="libexpat, libfakekey, libpng, libx11, libxft, libxrender"
NEOTERM_PKG_RECOMMENDS="ttf-dejavu"

neoterm_step_pre_configure() {
	autoreconf -i
}
