NEOTERM_PKG_HOMEPAGE=https://github.com/ToruNiina/toml11
NEOTERM_PKG_DESCRIPTION="toml11 is a C++11 (or later) header-only toml parser/encoder depending only on C++ standard library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.8.1"
NEOTERM_PKG_SRCURL=https://github.com/ToruNiina/toml11/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6a3d20080ecca5ea42102c078d3415bef80920f6c4ea2258e87572876af77849
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_CXX_STANDARD=11
"
