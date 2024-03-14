NEOTERM_SUBPKG_DESCRIPTION="fcitx5 gtk3 immodule"
NEOTERM_SUBPKG_INCLUDE="lib/gtk-3.0"
NEOTERM_SUBPKG_DEPENDS="fcitx5, gdk-pixbuf, gtk3, libc++, libcairo, libx11, libxkbcommon, pango"

neoterm_step_create_subpkg_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	"$NEOTERM_PREFIX/bin/gtk-query-immodules-3.0" \
		> "$NEOTERM_PREFIX/lib/gtk-3.0/3.0.0/immodules.cache"
	EOF
	cat <<- EOF > ./postrm
	#!$NEOTERM_PREFIX/bin/sh
	"$NEOTERM_PREFIX/bin/gtk-query-immodules-3.0" \
		> "$NEOTERM_PREFIX/lib/gtk-3.0/3.0.0/immodules.cache"
	EOF
}
