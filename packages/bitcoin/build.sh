NEOTERM_PKG_HOMEPAGE=https://bitcoincore.org/
NEOTERM_PKG_DESCRIPTION="Bitcoin Core"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="26.0"
NEOTERM_PKG_SRCURL=https://github.com/bitcoin/bitcoin/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=3eb7c1e35de9415f82737e48cdc6f0e7f4b75973cb123996662c1650f6d544cf
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_SERVICE_SCRIPT=("bitcoind" 'exec bitcoind 2>&1')
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-tests
--with-daemon
--with-gui=no
--without-libs
--prefix=${NEOTERM_PKG_SRCDIR}/depends/$NEOTERM_HOST_PLATFORM
--bindir=$NEOTERM_PREFIX/bin
--mandir=$NEOTERM_PREFIX/share/man
"

neoterm_step_pre_configure() {
	export ANDROID_TOOLCHAIN_BIN="$NEOTERM_STANDALONE_TOOLCHAIN/bin"
	(cd depends && make HOST=$NEOTERM_HOST_PLATFORM NO_QT=1 -j $NEOTERM_MAKE_PROCESSES)
	./autogen.sh
}
