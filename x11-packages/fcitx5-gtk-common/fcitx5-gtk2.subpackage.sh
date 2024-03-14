NEOTERM_SUBPKG_DESCRIPTION="fcitx5 gtk2 immodule"
NEOTERM_SUBPKG_INCLUDE="lib/gtk-2.0"
NEOTERM_SUBPKG_DEPENDS="fcitx5, gtk2, libx11, libxkbcommon, pango"

neoterm_step_create_subpkg_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	"$NEOTERM_PREFIX/bin/gtk-query-immodules-2.0" \
		> "$NEOTERM_PREFIX/lib/gtk-2.0/2.10.0/immodules.cache"
	EOF
	cat <<- EOF > ./postrm
	#!$NEOTERM_PREFIX/bin/sh
	"$NEOTERM_PREFIX/bin/gtk-query-immodules-2.0" \
		> "$NEOTERM_PREFIX/lib/gtk-2.0/2.10.0/immodules.cache"
	EOF
}
