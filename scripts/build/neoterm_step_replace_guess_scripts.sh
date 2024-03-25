neoterm_step_replace_guess_scripts() {
	[ "$NEOTERM_PKG_METAPACKAGE" = "true" ] && return

	cd "$NEOTERM_PKG_SRCDIR"
	find . -name config.sub -exec chmod u+w '{}' \; -exec cp "$NEOTERM_SCRIPTDIR/scripts/config.sub" '{}' \;
	find . -name config.guess -exec chmod u+w '{}' \; -exec cp "$NEOTERM_SCRIPTDIR/scripts/config.guess" '{}' \;

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ] && [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
		local list_files=$(grep -s -r -l '^#!.*/bin/' $NEOTERM_PKG_SRCDIR)
		if [ -n "$list_files" ]; then
			sed -i "s|#\!.*/bin/|#\!$NEOTERM_PREFIX_CLASSICAL/bin/|" $list_files
		fi
	fi
}
