neoterm_step_patch_package() {
	[ "$NEOTERM_PKG_METAPACKAGE" = "true" ] && return

	cd "$NEOTERM_PKG_SRCDIR"
	# Suffix patch with ".patch32" or ".patch64" to only apply for
	# these bitnesses
	local PATCHES=$(find $NEOTERM_PKG_BUILDER_DIR -mindepth 1 -maxdepth 1 \
			     -name \*.patch -o -name \*.patch$NEOTERM_ARCH_BITS | sort)
	local DEBUG_PATCHES=""
	if [ "$NEOTERM_DEBUG_BUILD" = "true" ]; then
		DEBUG_PATCHES=$(find $NEOTERM_PKG_BUILDER_DIR -mindepth 1 -maxdepth 1 -name \*.patch.debug | sort)
	fi
	local ON_DEVICE_PATCHES=""
	# .patch.ondevice patches should only be applied when building
	# on device
	if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ]; then
		ON_DEVICE_PATCHES=$(find $NEOTERM_PKG_BUILDER_DIR -mindepth 1 -maxdepth 1 -name \*.patch.ondevice | sort)
	fi
	shopt -s nullglob
	for patch in $PATCHES $DEBUG_PATCHES $ON_DEVICE_PATCHES; do
		echo "Applying patch: $(basename $patch)"
		test -f "$patch" && sed \
			-e "s%\@NEOTERM_APP_PACKAGE\@%${NEOTERM_APP_PACKAGE}%g" \
			-e "s%\@NEOTERM_BASE_DIR\@%${NEOTERM_BASE_DIR}%g" \
			-e "s%\@NEOTERM_CACHE_DIR\@%${NEOTERM_CACHE_DIR}%g" \
			-e "s%\@NEOTERM_HOME\@%${NEOTERM_ANDROID_HOME}%g" \
			-e "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" \
			-e "s%\@NEOTERM_PREFIX_CLASSICAL\@%${NEOTERM_PREFIX_CLASSICAL}%g" \
			"$patch" | patch --silent -p1
	done
	shopt -u nullglob
}
