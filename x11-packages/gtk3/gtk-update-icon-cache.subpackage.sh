NEOTERM_SUBPKG_INCLUDE="
bin/gtk-update-icon-cache
share/man/man1/gtk-update-icon-cache.1
"

NEOTERM_SUBPKG_DEPENDS="gdk-pixbuf, glib"
NEOTERM_SUBPKG_DESCRIPTION="GTK+ icon cache updater"

neoterm_step_create_subpkg_debscripts() {
	cat <<- EOF > ./triggers
	interest-noawait $NEOTERM_PREFIX/share/icons
	EOF

	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	for i in \$(find "$NEOTERM_PREFIX/share/icons" -type f -iname index.theme); do
		gtk-update-icon-cache --force --quiet \$(dirname "\${i}")
	done
	unset i
	exit 0
	EOF
}
