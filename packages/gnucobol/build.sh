NEOTERM_PKG_HOMEPAGE=https://gnucobol.sourceforge.io/
NEOTERM_PKG_DESCRIPTION="A free/libre COBOL compiler"
NEOTERM_PKG_LICENSE="GPL-3.0, LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.1.2
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/gnucobol/gnucobol-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=597005d71fd7d65b90cbe42bbfecd5a9ec0445388639404662e70d53ddf22574
NEOTERM_PKG_DEPENDS="json-c, libgmp, libvbisam, libxml2, ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-db
--with-json=json-c
--with-vbisam
"

neoterm_step_pre_configure() {
	local lp64="$(( $NEOTERM_ARCH_BITS / 32 - 1 ))"
	export COB_LI_IS_LL="${lp64}"
	export COB_32_BIT_LONG="$(( 1 - ${lp64} ))"
	export COB_HAS_64_BIT_POINTER="${lp64}"
}
