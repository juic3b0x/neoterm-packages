NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/neoterm-elf-cleaner
NEOTERM_PKG_DESCRIPTION="Cleaner of ELF files for Android"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Please update checksum in neoterm_step_start_build.sh as well if
# updating the package.
NEOTERM_PKG_VERSION=2.2.1
NEOTERM_PKG_SRCURL=https://github.com/juic3b0x/neoterm-elf-cleaner/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b51bc10aff3d733345e7809824c9c652fb228d92e229cd5eb63c48d67d7670cb
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_pre_configure() {
	autoreconf -vfi

	sed "s%@NEOTERM_PKG_API_LEVEL@%$NEOTERM_PKG_API_LEVEL%g" \
		"$NEOTERM_PKG_BUILDER_DIR"/android-api-level.diff | patch --silent -p1
}
