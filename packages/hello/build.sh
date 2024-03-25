NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/hello/
NEOTERM_PKG_DESCRIPTION="Prints a friendly greeting"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.12.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/hello/hello-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8d99142afd92576f30b0cd7cb42a8dc6809998bc5d607d88761f512e26c7db20
NEOTERM_PKG_DEPENDS="libiconv"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LDFLAGS+=" -liconv"
}
