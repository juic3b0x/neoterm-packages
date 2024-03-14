NEOTERM_PKG_HOMEPAGE=https://solidity.readthedocs.io
NEOTERM_PKG_DESCRIPTION="An Ethereum smart contract-oriented language"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.24"
NEOTERM_PKG_SRCURL=https://github.com/ethereum/solidity/releases/download/v${NEOTERM_PKG_VERSION}/solidity_${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=def2ab7c877fcd16c81a166cdc5b99bfabcee7e8d505afcce816e9b1e451c61a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="boost, jsoncpp, libc++"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DUSE_Z3=OFF
-DUSE_CVC4=OFF
-DUSE_LD_GOLD=OFF
-DBoost_USE_STATIC_LIBS=OFF
"
NEOTERM_CMAKE_BUILD="Unix Makefiles"

neoterm_step_pre_configure() {
	LDFLAGS+=" -ljsoncpp"
}
