neoterm_step_setup_build_folders() {
	# Following directories may contain files with read-only
	# permissions which makes them undeletable. We need to fix
	# that.
	[ -d "$NEOTERM_PKG_BUILDDIR" ] && chmod +w -R "$NEOTERM_PKG_BUILDDIR" || true
	[ -d "$NEOTERM_PKG_SRCDIR" ] && chmod +w -R "$NEOTERM_PKG_SRCDIR" || true
	if [ "$NEOTERM_SKIP_DEPCHECK" = false ] && \
		   [ "$NEOTERM_INSTALL_DEPS" = true ] && \
		   [ "$NEOTERM_PKG_METAPACKAGE" = false ] && \
		   [ "$NEOTERM_NO_CLEAN" = false ] && \
		   [ "$NEOTERM_ON_DEVICE_BUILD" = false ]; then
		# Remove all previously extracted/built files from
		# $NEOTERM_PREFIX:
		rm -fr $NEOTERM_PREFIX_CLASSICAL
		rm -f $NEOTERM_BUILT_PACKAGES_DIRECTORY/*
	fi

	# Cleanup old build state:
	rm -Rf "$NEOTERM_PKG_BUILDDIR" \
		"$NEOTERM_PKG_SRCDIR"

	# Cleanup old packaging state:
	rm -Rf "$NEOTERM_PKG_PACKAGEDIR" \
		"$NEOTERM_PKG_TMPDIR" \
		"$NEOTERM_PKG_MASSAGEDIR"

	# Ensure folders present (but not $NEOTERM_PKG_SRCDIR, it will
	# be created in build)
	mkdir -p "$NEOTERM_COMMON_CACHEDIR" \
		 "$NEOTERM_COMMON_CACHEDIR-$NEOTERM_ARCH" \
		 "$NEOTERM_COMMON_CACHEDIR-all" \
		 "$NEOTERM_OUTPUT_DIR" \
		 "$NEOTERM_PKG_BUILDDIR" \
		 "$NEOTERM_PKG_PACKAGEDIR" \
		 "$NEOTERM_PKG_TMPDIR" \
		 "$NEOTERM_PKG_CACHEDIR" \
		 "$NEOTERM_PKG_MASSAGEDIR"
	if [ "$NEOTERM_PACKAGE_LIBRARY" = "bionic" ]; then
		mkdir -p $NEOTERM_PREFIX/{bin,etc,lib,libexec,share,share/LICENSES,tmp,include}
	elif [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
		mkdir -p $NEOTERM_PREFIX/{bin,etc,lib,share,share/LICENSES,include}
		mkdir -p $NEOTERM_PREFIX_CLASSICAL/{bin,etc,tmp}
	fi
}
