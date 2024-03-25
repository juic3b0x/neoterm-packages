NEOTERM_PKG_HOMEPAGE=https://vicerveza.homeunix.net/~viric/soft/ts/
NEOTERM_PKG_DESCRIPTION="Task spooler is a Unix batch system where the tasks spooled run one after the other"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.0.0"
NEOTERM_PKG_SRCURL=https://github.com/justanhduc/task-spooler/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ffffa86f95071e837af619e23fb4a037432b0b079d872d58dc530883d1d33557
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_CONFLICTS="moreutils"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DTASK_SPOOLER_COMPILE_CUDA=OFF
"

neoterm_step_pre_configure() {
	# if $NEOTERM_ON_DEVICE_BUILD; then
	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
	    sed -i '/add_executable(makeman man.c)/d' ${NEOTERM_PKG_SRCDIR}/CMakeLists.txt
	    gcc -o ${NEOTERM_PKG_BUILDDIR}/makeman ${NEOTERM_PKG_SRCDIR}/man.c
	fi
}
