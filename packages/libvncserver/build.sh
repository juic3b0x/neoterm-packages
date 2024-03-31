NEOTERM_PKG_HOMEPAGE=https://libvnc.github.io/
NEOTERM_PKG_DESCRIPTION="Cross-platform C libraries that allow you to easily implement VNC server or client functionality"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.9.14"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/LibVNC/libvncserver/archive/LibVNCServer-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=83104e4f7e28b02f8bf6b010d69b626fae591f887e949816305daebae527c9a5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/.*-//'
NEOTERM_PKG_DEPENDS="libgcrypt, libgnutls, libjpeg-turbo, liblzo, libpng, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_OPENSSL=OFF
-DWITH_SASL=OFF
"

neoterm_step_post_massage() {
	local f
	for f in ./lib/pkgconfig/libvnc{client,server}.pc; do
		if [ -e "${f}" ]; then
			sed -i '/^Libs\.private:/s/ -l\(-pthread\)/ \1/' "${f}"
		fi
	done
}
