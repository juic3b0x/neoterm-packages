NEOTERM_PKG_HOMEPAGE="https://www.nongnu.org/atool"
NEOTERM_PKG_DESCRIPTION="tool for managing file archives of various types"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.39.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="https://download.savannah.gnu.org/releases/atool/atool-$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256="aaf60095884abb872e25f8e919a8a63d0dabaeca46faeba87d12812d6efc703b"
NEOTERM_PKG_DEPENDS="perl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_RECOMMENDS="arj, binutils-is-llvm | binutils, bzip2, cpio, file, gzip, lhasa, lzip, lzop, p7zip, tar, unrar, unzip, xz-utils, zip"
NEOTERM_PKG_SUGGESTS="bash-completion"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_post_make_install() {
	mkdir -p "$NEOTERM_PREFIX/share/bash-completion/completions"
	install -Dm600 "extra/bash-completion-atool_0.1-1" \
		"$NEOTERM_PREFIX/share/bash-completion/completions/atool"
}
