NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/ta-lib/
NEOTERM_PKG_DESCRIPTION="Technical analysis library with indicators like ADX"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.4.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://prdownloads.sourceforge.net/ta-lib/ta-lib-$NEOTERM_PKG_VERSION-src.tar.gz
NEOTERM_PKG_SHA256=9ff41efcb1c011a4b4b6dfc91610b06e39b1d7973ed5d4dee55029a0ac4dc651
NEOTERM_PKG_BREAKS="talib"
NEOTERM_PKG_REPLACES="talib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	curl https://sourceforge.net/p/ta-lib/code/HEAD/tree/tags/release-${NEOTERM_PKG_VERSION//./-}/ta-lib/LICENSE.TXT?format=raw -o $NEOTERM_PKG_SRCDIR/LICENSE
}
