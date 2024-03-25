NEOTERM_PKG_HOMEPAGE=https://tcl.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A windowing toolkit for use with tcl"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="license.terms"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=8.6.13
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/tcl/tk${NEOTERM_PKG_VERSION}-src.tar.gz
NEOTERM_PKG_SHA256=2e65fa069a23365440a3c56c556b8673b5e32a283800d8d9b257e3f584ce0675
NEOTERM_PKG_DEPENDS="fontconfig, libx11, libxft, libxss, tcl"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_MAKE_INSTALL_TARGET="install install-private-headers"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$NEOTERM_PREFIX/share/man
--enable-threads
--enable-64bit
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/unix"
}

neoterm_step_post_make_install() {
	ln -sfr "$NEOTERM_PREFIX/bin/wish${NEOTERM_PKG_VERSION:0:3}" \
		"$NEOTERM_PREFIX"/bin/wish
	ln -sfr "$NEOTERM_PREFIX/lib/libtk${NEOTERM_PKG_VERSION:0:3}.so" \
		"$NEOTERM_PREFIX"/lib/libtk.so

	cd "$NEOTERM_PKG_SRCDIR"/../

	for dir in compat generic generic/ttk unix; do
		install -dm755 "$NEOTERM_PREFIX/include/tk-private/$dir"
		install -m644 -t "$NEOTERM_PREFIX/include/tk-private/$dir" "$dir"/*.h
	done
}
