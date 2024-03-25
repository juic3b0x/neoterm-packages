NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/groff/
NEOTERM_PKG_DESCRIPTION="typesetting system that reads plain text mixed with formatting commands and produces formatted output"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.23.0
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/groff/groff-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6b9757f592b7518b4902eb6af7e54570bdccba37a871fddb2d30ae3863511c13
NEOTERM_PKG_DEPENDS="libc++, perl, man"
NEOTERM_PKG_GROUPS="base-devel"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
am_cv_func_iconv=no
"
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/soelim
share/man/man1/soelim.1*
share/man/man7/roff.7*
"

neoterm_step_pre_configure() {
	sed -i "s|@abs_top_builddir@|${NEOTERM_TOPDIR}/groff/host-build|" Makefile.in
}

neoterm_step_post_make_install() {
	install -Dm600 $NEOTERM_PKG_HOSTBUILD_DIR/font/devpdf/[A-CEG-Z]* \
		$NEOTERM_PREFIX/share/groff/current/font/devpdf/
}
