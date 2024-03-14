NEOTERM_PKG_HOMEPAGE="https://github.com/qucs/adms"
NEOTERM_PKG_DESCRIPTION="A code generator for the Verilog-AMS language"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.3.7"
NEOTERM_PKG_SRCURL="https://github.com/Qucs/ADMS/archive/refs/tags/release-$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=0d24f645d7ce0daa447af1b0cff1123047f3b73cc41cf403650f469721f95173
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-maintainer-mode
--enable-shared
--disable-static
"

neoterm_step_pre_configure() {
	./bootstrap.sh
}
