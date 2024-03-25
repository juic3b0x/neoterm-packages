NEOTERM_PKG_HOMEPAGE=http://mattmahoney.net/dc/zpaq.html
NEOTERM_PKG_DESCRIPTION="Programmable file compressor, library and utilities. Based on the PAQ compression algorithm"
NEOTERM_PKG_LICENSE="MIT, Unlicense"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=7.15
NEOTERM_PKG_SRCURL=https://github.com/zpaq/zpaq/archive/refs/tags/${NEOTERM_PKG_VERSION}.zip
NEOTERM_PKG_SHA256=2d13de90fdd89a8e9eeda4afbf76610d3ace4aa675795b7c3a9f13b21fbdbe3e
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_DEPENDS="perl"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CXXFLAGS+=" -O3"
	if [ $NEOTERM_ARCH = "aarch64" ]; then
		CPPFLAGS+=" -DNOJIT"
	elif [ $NEOTERM_ARCH = "arm" ]; then
		CPPFLAGS+=" -DNOJIT"
	elif [ $NEOTERM_ARCH = "i686" ]; then
		CPPFLAGS+=" -Dunix"
	elif [ $NEOTERM_ARCH = "x86_64" ]; then
		CPPFLAGS+=" -Dunix"
	fi
}
