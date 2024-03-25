NEOTERM_PKG_HOMEPAGE=https://include-what-you-use.org/
NEOTERM_PKG_DESCRIPTION="A tool to analyze #includes in C and C++ source files"
NEOTERM_PKG_LICENSE=NCSA
NEOTERM_PKG_MAINTAINER="@neoterm"
# Update this when libllvm is updated:
NEOTERM_PKG_VERSION=0.21
NEOTERM_PKG_SRCURL=https://github.com/include-what-you-use/include-what-you-use/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=a472fe8587376d041585c72e5643200f8929899f787725f0ba9e5b3d3820d401
NEOTERM_PKG_AUTO_UPDATE=false # can't be auto-updated since release correspond to clang version.
NEOTERM_PKG_DEPENDS="clang, libc++, python"
NEOTERM_PKG_BUILD_DEPENDS="libllvm-static"
