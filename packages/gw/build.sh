NEOTERM_PKG_HOMEPAGE=https://github.com/kcleal/gw
NEOTERM_PKG_DESCRIPTION="A browser for genomic sequencing data (.bam/.cram format)"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="clealk@cardiff.ac.uk"
NEOTERM_PKG_VERSION=0.9.3
NEOTERM_PKG_SRCURL=https://github.com/kcleal/gw/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=43445ef6d96bd8a09a9a45cd18e21481d7fefe7e9ab26aec4abd8d1f4bff3fcd
NEOTERM_PKG_DEPENDS="glfw, htslib, libc++, libjpeg-turbo, opengl"
NEOTERM_PKG_BUILD_DEPENDS="fontconfig, freetype, libicu, libuuid, mesa-dev"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

# htslib is not available for arm.
NEOTERM_PKG_BLACKLISTED_ARCHES="arm"

neoterm_step_pre_configure() {
	LDFLAGS+=" -llog"

	sed -i \
		-e '/\/usr\/local\/include/d' \
		-e '/\/usr\/local\/lib/d' \
		./Makefile

	if [ "$NEOTERM_ARCH" = "aarch64" ]; then
		sed -i 's/Release-x64/Release-arm64/g' ./Makefile
	elif [ "$NEOTERM_ARCH" = "i686" ]; then
		sed -i 's/Release-x64/Release-x86/g' ./Makefile
	fi
}

neoterm_step_make() {
	local SKIA_URL_AARCH64="https://github.com/JetBrains/skia-build/releases/download/m93-87e8842e8c/Skia-m93-87e8842e8c-android-Release-arm64.zip"
	local SKIA_CHECKSUM_AARCH64="7286fe634cfcd499ef1232b9bdc6b08220daebde0de483639ed498a1dc1ec62e"
	local SKIA_URL_X86="https://github.com/JetBrains/skia-build/releases/download/m93-87e8842e8c/Skia-m93-87e8842e8c-android-Release-x86.zip"
	local SKIA_CHECKSUM_X86="e79868a2b791ec44673f981b68d5cb658dad3fcef97932ac7b4a80c3dd329e87"
	local SKIA_URL_X64="https://github.com/JetBrains/skia-build/releases/download/m93-87e8842e8c/Skia-m93-87e8842e8c-android-Release-x64.zip"
	local SKIA_CHECKSUM_X64="1546e41c0b2edc401639e1ed0dd32d9e8b30d478f1c4a5c345ee82f2a5e1b829"

	mkdir -p lib/skia && cd lib/skia/
	case "$NEOTERM_ARCH" in
		aarch64)
			neoterm_download "$SKIA_URL_AARCH64" "${NEOTERM_PKG_CACHEDIR}/skia-${NEOTERM_ARCH}.zip" "$SKIA_CHECKSUM_AARCH64"
			;;
		i686)
			neoterm_download "$SKIA_URL_X86" "${NEOTERM_PKG_CACHEDIR}/skia-${NEOTERM_ARCH}.zip" "$SKIA_CHECKSUM_X86"
			;;
		x86_64)
			neoterm_download "$SKIA_URL_X64" "${NEOTERM_PKG_CACHEDIR}/skia-${NEOTERM_ARCH}.zip" "$SKIA_CHECKSUM_X64"
			;;
		*)
			neoterm_error_exit "No architecture '$NEOTERM_ARCH' defined for Skia download."
			;;
	esac
	unzip -o "${NEOTERM_PKG_CACHEDIR}/skia-${NEOTERM_ARCH}.zip"
	cd ../../

	make -j "$NEOTERM_MAKE_PROCESSES"
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}/bin" ./gw
	install -Dm600 ./.gw.ini "${NEOTERM_PREFIX}/share/doc/gw/gw.ini"
}
