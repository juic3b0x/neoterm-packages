NEOTERM_PKG_HOMEPAGE=https://unicode.org/ucd/
NEOTERM_PKG_DESCRIPTION="The Unicode Character Database (UCD)"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="copyright.html"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=15.1.0
NEOTERM_PKG_SRCURL=(https://unicode.org/Public/zipped/${NEOTERM_PKG_VERSION}/UCD.zip
                   https://unicode.org/Public/zipped/${NEOTERM_PKG_VERSION}/Unihan.zip)
NEOTERM_PKG_SHA256=(cb1c663d053926500cd501229736045752713a066bd75802098598b7a7056177
                   a0226610e324bcf784ac380e11f4cbf533ee1e6b3d028b0991bf8c0dc3f85853)
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
#The package contains multiple SRCURL and SHA256, this is not supported by auto-updater script
NEOTERM_PKG_AUTO_UPDATE=false

neoterm_step_get_source() {
	local i
	for i in $(seq 0 $(( ${#NEOTERM_PKG_SRCURL[@]}-1 ))); do
		local f="${NEOTERM_PKG_NAME}-$(basename "${NEOTERM_PKG_SRCURL[$i]}")"
		neoterm_download \
			"${NEOTERM_PKG_SRCURL[$i]}" \
			"$NEOTERM_PKG_CACHEDIR/${f}" \
			"${NEOTERM_PKG_SHA256[$i]}"
	done
	mkdir -p "$NEOTERM_PKG_SRCDIR"
	unzip -d "$NEOTERM_PKG_SRCDIR" \
		"$NEOTERM_PKG_CACHEDIR/${NEOTERM_PKG_NAME}-UCD.zip"
	cp "$NEOTERM_PKG_CACHEDIR/${NEOTERM_PKG_NAME}-Unihan.zip" \
		"$NEOTERM_PKG_SRCDIR/Unihan.zip"
}

neoterm_step_post_get_source() {
	cp $NEOTERM_PKG_BUILDER_DIR/copyright.html ./
}

neoterm_step_make_install() {
	cp -rT "$NEOTERM_PKG_SRCDIR" "$NEOTERM_PREFIX/share/${NEOTERM_PKG_NAME}"
}
