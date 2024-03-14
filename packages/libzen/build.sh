NEOTERM_PKG_HOMEPAGE=https://mediaarea.net/en/MediaInfo
NEOTERM_PKG_DESCRIPTION="ZenLib C++ utility library"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_LICENSE_FILE="../../../License.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.4.41
NEOTERM_PKG_SRCURL=https://mediaarea.net/download/source/libzen/${NEOTERM_PKG_VERSION}/libzen_${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=aad6c25bffcc695828e4d36700243a19a0d9503fbe57d38a2fbfa302fb34df2f
NEOTERM_PKG_DEPENDS="libandroid-support, libc++"
NEOTERM_PKG_BUILD_DEPENDS="libandroid-glob"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-shared --enable-static"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR="${NEOTERM_PKG_SRCDIR}/Project/GNU/Library"
	NEOTERM_PKG_BUILDDIR="${NEOTERM_PKG_SRCDIR}"
	cd "${NEOTERM_PKG_SRCDIR}" || return
	./autogen.sh

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
