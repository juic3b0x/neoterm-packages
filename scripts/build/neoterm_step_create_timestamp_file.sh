neoterm_step_create_timestamp_file() {
	# Keep track of when build started so we can see what files
	# have been created.  We start by sleeping so that any
	# generated files (such as zlib.pc) get an older timestamp
	# than the NEOTERM_BUILD_TS_FILE.
	sleep 1
	NEOTERM_BUILD_TS_FILE=$NEOTERM_PKG_TMPDIR/timestamp_$NEOTERM_PKG_NAME
	touch "$NEOTERM_BUILD_TS_FILE"
}
