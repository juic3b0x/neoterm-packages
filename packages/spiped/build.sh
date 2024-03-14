NEOTERM_PKG_HOMEPAGE=https://www.tarsnap.com/spiped.html
NEOTERM_PKG_DESCRIPTION="a utility for creating symmetrically encrypted and authenticated pipes between socket addresses"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/Tarsnap/spiped/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=7824f74e8dd123ca3075032281c11fbb9ba5a9ec8410e100012ca45210a170f6
NEOTERM_PKG_DEPENDS="openssl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_pre_configure() {
	if [[ "${NEOTERM_ARCH}" == "arm" ]]; then
		# armv8 specific features check also enables them for armv7. But why?
		patch -p1 --silent <"${NEOTERM_PKG_BUILDER_DIR}"/disable_armv8_specific_features.diff
	fi
}

neoterm_step_make() {
	CFLAGS+=" $CPPFLAGS"
	env LDADD_EXTRA="$LDFLAGS" \
		make -j "$NEOTERM_MAKE_PROCESSES" BINDIR="$NEOTERM_PREFIX/bin" \
		MAN1DIR="$NEOTERM_PREFIX/share/man/man1"
}

neoterm_step_make_install() {
	make install BINDIR="$NEOTERM_PREFIX/bin" \
		MAN1DIR="$NEOTERM_PREFIX/share/man/man1"
}
