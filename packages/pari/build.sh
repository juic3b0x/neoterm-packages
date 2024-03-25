NEOTERM_PKG_HOMEPAGE=https://pari.math.u-bordeaux.fr/
NEOTERM_PKG_DESCRIPTION="A computer algebra system designed for fast computations in number theory"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.15.5"
NEOTERM_PKG_SRCURL=https://pari.math.u-bordeaux.fr/pub/pari/unix/pari-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0efdda7515d9d954f63324c34b34c560e60f73a81c3924a71260a2cc91d5f981
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="gzip, libgmp, readline"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-gmp=$NEOTERM_PREFIX
--with-readline=$NEOTERM_PREFIX
"

neoterm_step_pre_configure() {
	LD="$CC"
	case $NEOTERM_ARCH_BITS in
		32) PARI_DOUBLE_FORMAT=1 ;;
		64) PARI_DOUBLE_FORMAT=- ;;
	esac
	export PARI_DOUBLE_FORMAT
}

neoterm_step_configure() {
	./Configure --prefix=$NEOTERM_PREFIX --host=$NEOTERM_HOST_PLATFORM \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
	NEOTERM_PKG_EXTRA_MAKE_ARGS="-C $(echo O*)"
}
