neoterm_step_finish_build() {
	echo "neoterm - build of '$NEOTERM_PKG_NAME' done"
	test -t 1 && printf "\033]0;%s - DONE\007" "$NEOTERM_PKG_NAME"

	mkdir -p "$NEOTERM_BUILT_PACKAGES_DIRECTORY"
	echo "$NEOTERM_PKG_FULLVERSION" > "$NEOTERM_BUILT_PACKAGES_DIRECTORY/$NEOTERM_PKG_NAME"

	for subpackage in "$NEOTERM_PKG_BUILDER_DIR"/*.subpackage.sh; do
		local subpkg_name="$(basename $subpackage | sed 's@\.subpackage\.sh@@g')"
		echo "$NEOTERM_PKG_FULLVERSION" > "$NEOTERM_BUILT_PACKAGES_DIRECTORY/${subpkg_name}"
	done
	exit 0
}
