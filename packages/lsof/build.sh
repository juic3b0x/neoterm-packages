NEOTERM_PKG_HOMEPAGE=https://github.com/lsof-org/lsof
NEOTERM_PKG_DESCRIPTION="Lists open files for running Unix processes"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.99.3"
NEOTERM_PKG_SRCURL=https://github.com/lsof-org/lsof/archive/${NEOTERM_PKG_VERSION}/lsof-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b9c56468b927d9691ab168c0b1e9f8f1f835694a35ff898c549d383bd8d09bd4
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support, libtirpc"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-libtirpc
--with-selinux=no
"

neoterm_step_pre_configure() {
	autoreconf -fiv
}
