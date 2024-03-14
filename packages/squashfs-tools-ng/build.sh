NEOTERM_PKG_HOMEPAGE=https://github.com/AgentD/squashfs-tools-ng
NEOTERM_PKG_DESCRIPTION="New set of tools for working with SquashFS images"
NEOTERM_PKG_LICENSE="LGPL-3.0, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.0"
NEOTERM_PKG_SRCURL="https://github.com/AgentD/squashfs-tools-ng/archive/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=f29301ebf084d0faa996eb7acce055551d4a8b5ed5c796fbcc31ed621800b88c
NEOTERM_PKG_DEPENDS="liblz4, liblzma, liblzo, zlib, zstd"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_pre_configure(){
	autoreconf -fi
}
