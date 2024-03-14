NEOTERM_PKG_HOMEPAGE=https://www.ledger-cli.org
NEOTERM_PKG_DESCRIPTION="Powerful, double-entry accounting system"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.3.2"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/ledger/ledger/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=555296ee1e870ff04e2356676977dcf55ebab5ad79126667bc56464cb1142035
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="boost, libc++, libedit, libmpfr, libgmp, python"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers, utf8cpp"
NEOTERM_PKG_BREAKS="ledger-dev"
NEOTERM_PKG_REPLACES="ledger-dev"
# See https://gitlab.kitware.com/cmake/cmake/issues/18865:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBoost_NO_BOOST_CMAKE=ON
-DUSE_PYTHON=ON
-DUTFCPP_PATH=$NEOTERM_PREFIX/include/utf8cpp
"

neoterm_step_pre_configure() {
	sed $NEOTERM_PKG_BUILDER_DIR/CMakeLists.diff \
		-e "s%@NEOTERM_PREFIX@%${NEOTERM_PREFIX}%g" \
		-e "s%@PYTHON_VERSION@%${NEOTERM_PYTHON_VERSION}%g" \
		| patch --silent -p1
}
