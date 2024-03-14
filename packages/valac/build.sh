NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Vala
NEOTERM_PKG_DESCRIPTION="C# like language for the GObject system"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.56.15"
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/vala/${NEOTERM_PKG_VERSION%.*}/vala-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=535b6452ed310fd5fb5c7dd6794b6213dac3b48e645e5bff3173741ec2cb3f2b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib"
NEOTERM_PKG_RECOMMENDS="clang, pkg-config"
NEOTERM_PKG_BREAKS="valac-dev"
NEOTERM_PKG_REPLACES="valac-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-cgraph=no"

neoterm_step_post_make_install() {
	local v=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1-2)
	ln -sf vala-${v}/libvalaccodegen.so $NEOTERM_PREFIX/lib/libvalaccodegen.so
}
