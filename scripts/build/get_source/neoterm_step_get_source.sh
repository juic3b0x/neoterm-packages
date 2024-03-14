neoterm_step_get_source() {
	: "${NEOTERM_PKG_SRCURL:=""}"

	if [ "${NEOTERM_PKG_SRCURL:0:4}" == "git+" ]; then
		neoterm_git_clone_src
	else
		if [ -z "${NEOTERM_PKG_SRCURL}" ] || [ "${NEOTERM_PKG_SKIP_SRC_EXTRACT-false}" = "true" ] || [ "$NEOTERM_PKG_METAPACKAGE" = "true" ]; then
			mkdir -p "$NEOTERM_PKG_SRCDIR"
			return
		fi
		neoterm_download_src_archive
		cd $NEOTERM_PKG_TMPDIR
		neoterm_extract_src_archive
	fi
}
