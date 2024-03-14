NEOTERM_PKG_HOMEPAGE=https://git.kernel.org/cgit/devel/pahole/pahole.git/
NEOTERM_PKG_DESCRIPTION="Pahole and other DWARF utils"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.25
NEOTERM_PKG_SRCURL=https://fedorapeople.org/~acme/dwarves/dwarves-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=e7d45955f6f4eca25a4c8c3bd6611059b35dc217e45976681d7db170fccdec4a
NEOTERM_PKG_DEPENDS="argp, libdw, libelf, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-D__LIB=lib"

neoterm_step_pre_configure() {
	cp $NEOTERM_PKG_BUILDER_DIR/obstack.h "$NEOTERM_PKG_SRCDIR"/
}
