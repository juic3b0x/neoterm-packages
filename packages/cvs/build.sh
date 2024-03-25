NEOTERM_PKG_HOMEPAGE=https://www.nongnu.org/cvs/
NEOTERM_PKG_DESCRIPTION="Concurrent Versions System"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:1.12.13"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL="https://github.com/juic3b0x/distfiles/releases/download/2021.01.04/cvs-${NEOTERM_PKG_VERSION:2}+real-26.tar.xz"
NEOTERM_PKG_SHA256=0eda91f5e8091b676c90b2a171f24f9293acb552f4e4f77b590ae8d92a547256
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="zlib, libandroid-support"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
cvs_cv_func_printf_ptr=yes
ac_cv_header_syslog_h=no
--disable-server
--with-external-zlib
"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/cvsbug share/man/man8/cvsbug.8"
