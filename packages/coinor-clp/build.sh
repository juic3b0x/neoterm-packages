NEOTERM_PKG_HOMEPAGE=https://github.com/coin-or/Clp
NEOTERM_PKG_DESCRIPTION="An open-source linear programming solver"
NEOTERM_PKG_LICENSE="EPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:1.17.9
NEOTERM_PKG_SRCURL=https://github.com/coin-or/Clp/archive/refs/tags/releases/${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=b02109be54e2c9c6babc9480c242b2c3c7499368cfca8c0430f74782a694a49f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libc++, libcoinor-osi, libcoinor-utils"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
