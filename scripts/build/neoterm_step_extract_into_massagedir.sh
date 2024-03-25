neoterm_step_extract_into_massagedir() {
	local TARBALL_ORIG=$NEOTERM_PKG_PACKAGEDIR/${NEOTERM_PKG_NAME}_orig.tar.gz

	# Build diff tar with what has changed during the build:
	cd $NEOTERM_PREFIX_CLASSICAL
	tar -N "$NEOTERM_BUILD_TS_FILE" \
		--exclude='tmp' \
		-czf "$TARBALL_ORIG" .

	# Extract tar in order to massage it
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX"
	cd "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX_CLASSICAL"
	tar xf "$TARBALL_ORIG"
	rm "$TARBALL_ORIG"
}
