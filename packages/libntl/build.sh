NEOTERM_PKG_HOMEPAGE="https://libntl.org"
NEOTERM_PKG_DESCRIPTION="A Library for doing Number Theory"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_LICENSE_FILE="doc/copying.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="11.5.1"
NEOTERM_PKG_REVISION="1"
NEOTERM_PKG_SRCURL="https://libntl.org/ntl-$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=210d06c31306cbc6eaf6814453c56c776d9d8e8df36d74eb306f6a523d1c6a8a
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_BUILD_DEPENDS="perl"
NEOTERM_PKG_DEPENDS="libgf2x, libgmp"

neoterm_step_configure() {
	cd src

	case "$NEOTERM_ARCH" in
		x86_64 | i686 )
			tune="x86";;
		* )
			tune="generic";;
	esac

	./configure \
		PREFIX=$NEOTERM_PREFIX\
		NATIVE=off \
		TUNE="$tune" \
		NTL_GMP_LIP=on \
		NTL_GF2X_LIB=off
}

neoterm_step_make() {
	cd src
	make
}

neoterm_step_make_install() {
	cd src
	make install
}
