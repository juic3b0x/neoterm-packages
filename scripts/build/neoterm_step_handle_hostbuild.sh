neoterm_step_handle_hostbuild() {
	[ "$NEOTERM_PKG_METAPACKAGE" = "true" ] && return
	[ "$NEOTERM_PKG_HOSTBUILD" = "false" ] && return

	cd "$NEOTERM_PKG_SRCDIR"
	for patch in $NEOTERM_PKG_BUILDER_DIR/*.patch.beforehostbuild; do
		echo "Applying patch: $(basename $patch)"
		test -f "$patch" && sed "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" "$patch" | patch --silent -p1
	done

	if [ ! -f "$NEOTERM_HOSTBUILD_MARKER" ]; then
		rm -Rf "$NEOTERM_PKG_HOSTBUILD_DIR"
		mkdir -p "$NEOTERM_PKG_HOSTBUILD_DIR"
		cd "$NEOTERM_PKG_HOSTBUILD_DIR"
		neoterm_step_host_build
		touch "$NEOTERM_HOSTBUILD_MARKER"
	fi
}
