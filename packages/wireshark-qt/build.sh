NEOTERM_PKG_HOMEPAGE=https://www.wireshark.org/
NEOTERM_PKG_DESCRIPTION="Network protocol analyzer"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.0.6
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.wireshark.org/download/src/all-versions/wireshark-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=0079097a1b17ebc7250a73563f984c13327dac5016b7d53165810fbcca4bd884
NEOTERM_PKG_DEPENDS="brotli, c-ares, glib, krb5, libandroid-support, libc++, libgcrypt, libgnutls, liblua52, liblz4, libmaxminddb, libminizip, libnghttp2, libnl, libopus, libpcap, libsnappy, libssh, libxml2, pcre2, qt5-qtbase, qt5-qtmultimedia, speexdsp, zlib, zstd"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_CONFLICTS="tshark, wireshark, wireshark-cli, wireshark-gtk"
NEOTERM_PKG_PROVIDES="tshark, wireshark, wireshark-cli, wireshark-gtk"
NEOTERM_PKG_REPLACES="tshark, wireshark, wireshark-cli, wireshark-gtk"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DLEMON_C_COMPILER=gcc-wrapper
-DM_INCLUDE_DIR=$NEOTERM_PREFIX/include
-DHAVE_C99_VSNPRINTF_EXITCODE=0
-DHAVE_C99_VSNPRINTF_EXITCODE__TRYRUN_OUTPUT=
-DENABLE_SMI=OFF
-DENABLE_SBC=OFF
-DENABLE_SPANDSP=OFF
-DENABLE_BCG729=OFF
-DENABLE_ILBC=OFF
-DENABLE_CAP=OFF
-DCMAKE_DISABLE_FIND_PACKAGE_DOXYGEN=ON
-DCMAKE_DISABLE_FIND_PACKAGE_Asciidoctor=ON
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -lm"

	local bin="$NEOTERM_PKG_BUILDDIR/_bin"
	rm -rf "${bin}"
	mkdir -p "${bin}"
	cat > "${bin}/gcc-wrapper" <<-EOF
		#!$(command -v bash)
		args=()
		for a in "\$@"; do
			case "\${a}" in
				--target=*|--gcc-toolchain=*|--sysroot=* ) ;;
				-fopenmp|-static-openmp ) ;;
				-Wl,--fix-cortex-a8|-Wl,-z,nocopyreloc ) ;;
				*-landroid-support* ) ;;
				* ) args+=("\${a}") ;;
			esac
		done
		exec $(command -v gcc) "\${args[@]}"
	EOF
	chmod 0700 "${bin}/gcc-wrapper"
	export PATH="${bin}:$PATH"
}
