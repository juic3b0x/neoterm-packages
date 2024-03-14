NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/wdiff/
NEOTERM_PKG_DESCRIPTION="Display word differences between text files"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@harieamjari"
NEOTERM_PKG_VERSION=1.2.2
NEOTERM_PKG_REVISION=1
#NEOTERM_PKG_SRCURL=http://ftp.gnu.org/gnu/wdiff/wdiff-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SRCURL=https://fossies.org/linux/misc/wdiff-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=34ff698c870c87e6e47a838eeaaae729fa73349139fc8db12211d2a22b78af6b
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-threads
"
