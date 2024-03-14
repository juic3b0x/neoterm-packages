NEOTERM_PKG_HOMEPAGE=https://people.redhat.com/sgrubb/libcap-ng/
NEOTERM_PKG_DESCRIPTION="Library making programming with POSIX capabilities easier than traditional libcap"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2:0.8.4"
NEOTERM_PKG_SRCURL=https://github.com/stevegrubb/libcap-ng/archive/v${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=5615c76a61039e283a6bd107c4faf345ae5ad4dcd45907defe5e474d8fdb6fd2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-python
--without-python3
"

neoterm_step_pre_configure() {
	./autogen.sh
}
