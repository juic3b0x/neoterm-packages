NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/diffutils/
NEOTERM_PKG_DESCRIPTION="Programs (cmp, diff, diff3 and sdiff) related to finding differences between files"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.10
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/diffutils/diffutils-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=90e5e93cc724e4ebe12ede80df1634063c7a855692685919bfe60b556c9bd09e
NEOTERM_PKG_DEPENDS="libiconv"
NEOTERM_PKG_ESSENTIAL=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_PR_PROGRAM=${NEOTERM_PREFIX}/bin/pr"
