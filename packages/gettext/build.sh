NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/gettext/
NEOTERM_PKG_DESCRIPTION="GNU Internationalization utilities"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.22.5"
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/gettext/gettext-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=fe10c37353213d78a5b83d48af231e005c4da84db5ce88037d88355938259640
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libiconv, libunistring, libxml2, ncurses"
NEOTERM_PKG_BREAKS="gettext-dev"
NEOTERM_PKG_REPLACES="gettext-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_have_decl_posix_spawn=no
ac_cv_header_spawn_h=no
gl_cv_func_working_error=yes
gl_cv_terminfo_tparm=yes
--disable-openmp
--with-included-libcroco
--with-included-libglib
--without-included-libxml
"
NEOTERM_PKG_GROUPS="base-devel"

neoterm_step_pre_configure() {
	if [ $NEOTERM_ARCH_BITS = 32 ]; then
		LDFLAGS+=" -Wl,-z,muldefs"
	fi
}

neoterm_step_post_configure() {
	local pv=$(awk '/^PACKAGE_VERSION =/ { print $3 }' Makefile)
	local lib
	for lib in libgettext{lib,src}; do
		ln -sf ${lib}-${pv}.so $NEOTERM_PREFIX/lib/${lib}.so
	done
}
