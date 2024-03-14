NEOTERM_PKG_HOMEPAGE=https://github.com/mypaint/libmypaint
NEOTERM_PKG_DESCRIPTION="MyPaint brush engine library"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/mypaint/libmypaint/releases/download/v${NEOTERM_PKG_VERSION}/libmypaint-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=741754f293f6b7668f941506da07cd7725629a793108bb31633fb6c3eae5315f
NEOTERM_PKG_DEPENDS="glib, json-c"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection
--with-glib
ac_cv_func_bind_textdomain_codeset=yes
ac_cv_search_dgettext=yes
gt_cv_func_dgettext_libc=yes
gt_cv_func_ngettext_libc=yes
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}

neoterm_step_post_configure() {
	# What is this?
	find . -name Makefile | xargs -n 1 sed -i 's/ yes -lm/ -lm/g'
}
