NEOTERM_PKG_HOMEPAGE=https://www.tug.org/texworks/
NEOTERM_PKG_DESCRIPTION="TeXworks is an environment for authoring TeX (LaTeX, ConTeXt, etc) documents"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.6.9"
NEOTERM_PKG_SRCURL=https://github.com/TeXworks/texworks/archive/refs/tags/release-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a0c8e4b9f2fbb38f681b9d91f331366e5cdcb35dba7a94cb2988ccfca113ac2b
NEOTERM_PKG_DEPENDS="hunspell, libc++, liblua53, poppler-qt, qt5-qtbase, qt5-qtdeclarative, qt5-qtscript, zlib"
NEOTERM_PKG_BUILD_DEPENDS="git, qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DLUA_MATH_LIBRARY=
"
