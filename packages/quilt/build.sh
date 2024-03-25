NEOTERM_PKG_HOMEPAGE=https://savannah.nongnu.org/projects/quilt
NEOTERM_PKG_DESCRIPTION="Allows you to easily manage large numbers of patches"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.67
NEOTERM_PKG_SRCURL=https://savannah.nongnu.org/download/quilt/quilt-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3be3be0987e72a6c364678bb827e3e1fcc10322b56bc5f02b576698f55013cc2
NEOTERM_PKG_DEPENDS="coreutils, diffstat, gawk, graphviz, perl"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-diffstat=$NEOTERM_PREFIX/bin/diffstat
--without-7z
--without-rpmbuild
--without-sendmail
"

neoterm_step_post_make_install() {
	ln -sf $NEOTERM_PREFIX/bin/gawk $NEOTERM_PREFIX/share/quilt/compat/awk
}
