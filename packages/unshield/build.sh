NEOTERM_PKG_HOMEPAGE=https://github.com/twogood/unshield
NEOTERM_PKG_DESCRIPTION="Tool and library to extract CAB files from InstallShield installers"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.1
NEOTERM_PKG_SRCURL=https://github.com/twogood/unshield/archive/1.4.3.tar.gz
NEOTERM_PKG_SHA256=aa8c978dc0eb1158d266eaddcd1852d6d71620ddfc82807fe4bf2e19022b7bab
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libiconv, openssh, zlib"

neoterm_step_pre_configure() {
	LDFLAGS+=" -liconv"
}
