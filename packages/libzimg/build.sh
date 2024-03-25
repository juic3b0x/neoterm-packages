NEOTERM_PKG_HOMEPAGE=https://github.com/sekrit-twc/zimg
NEOTERM_PKG_DESCRIPTION="Scaling, colorspace conversion, and dithering library"
NEOTERM_PKG_LICENSE="WTFPL"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.0.5
NEOTERM_PKG_SRCURL=https://github.com/sekrit-twc/zimg/archive/release-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a9a0226bf85e0d83c41a8ebe4e3e690e1348682f6a2a7838f1b8cbff1b799bcf
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
