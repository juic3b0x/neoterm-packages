NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/texinfo/
NEOTERM_PKG_DESCRIPTION="Documentation system for on-line information and printed output"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="7.1"
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/texinfo/texinfo-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=deeec9f19f159e046fdf8ad22231981806dac332cc372f1c763504ad82b30953
NEOTERM_PKG_AUTO_UPDATE=true
# gawk is used by texindex:
NEOTERM_PKG_DEPENDS="libiconv, ncurses, perl, gawk"
NEOTERM_PKG_RECOMMENDS="update-info-dir"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="texinfo_cv_sys_iconv_converts_euc_cn=no --disable-perl-xs"
NEOTERM_PKG_GROUPS="base-devel"
