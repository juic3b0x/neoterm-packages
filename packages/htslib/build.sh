NEOTERM_PKG_HOMEPAGE=https://github.com/samtools/htslib
NEOTERM_PKG_DESCRIPTION="C library for high-throughput sequencing data formats"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.19.1"
NEOTERM_PKG_SRCURL=https://github.com/samtools/htslib/releases/download/${NEOTERM_PKG_VERSION}/htslib-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=222d74d3574fb67b158c6988c980eeaaba8a0656f5e4ffb76b5fa57f035933ec
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libbz2, liblzma, zlib, libdeflate, libcurl"

# error: assigning to 'uint8x8_t' (vector of 8 'uint8_t' values) from incompatible type 'int'
NEOTERM_PKG_BLACKLISTED_ARCHES="arm"

neoterm_step_pre_configure() {
	autoreconf -fi
}
