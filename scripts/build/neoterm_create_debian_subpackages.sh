neoterm_create_debian_subpackages() {
	# Sub packages:
	local _ADD_PREFIX=""
	if [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
		_ADD_PREFIX="glibc/"
	fi
	if [ "$NEOTERM_PKG_NO_STATICSPLIT" = "false" ] && [[ -n $(shopt -s globstar; shopt -s nullglob; echo ${_ADD_PREFIX}lib/**/*.a) ]]; then
		# Add virtual -static sub package if there are include files:
		local _STATIC_SUBPACKAGE_FILE=$NEOTERM_PKG_TMPDIR/${NEOTERM_PKG_NAME}-static.subpackage.sh
		echo NEOTERM_SUBPKG_INCLUDE=\"$(find ${_ADD_PREFIX}lib -name '*.a' -o -name '*.la') $NEOTERM_PKG_STATICSPLIT_EXTRA_PATTERNS\" > "$_STATIC_SUBPACKAGE_FILE"
		echo "NEOTERM_SUBPKG_DESCRIPTION=\"Static libraries for ${NEOTERM_PKG_NAME}\"" >> "$_STATIC_SUBPACKAGE_FILE"
	fi

	# Now build all sub packages
	rm -Rf "$NEOTERM_TOPDIR/$NEOTERM_PKG_NAME/subpackages"
	for subpackage in $NEOTERM_PKG_BUILDER_DIR/*.subpackage.sh $NEOTERM_PKG_TMPDIR/*subpackage.sh; do
		test ! -f "$subpackage" && continue
		local SUB_PKG_NAME
		SUB_PKG_NAME=$(basename "$subpackage" .subpackage.sh)
		if [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ] && ! package__is_package_name_have_glibc_prefix "$SUB_PKG_NAME"; then
			SUB_PKG_NAME="$(package__add_prefix_glibc_to_package_name ${SUB_PKG_NAME})"
		fi
		# Default value is same as main package, but sub package may override:
		local NEOTERM_SUBPKG_PLATFORM_INDEPENDENT=$NEOTERM_PKG_PLATFORM_INDEPENDENT
		local SUB_PKG_DIR=$NEOTERM_TOPDIR/$NEOTERM_PKG_NAME/subpackages/$SUB_PKG_NAME
		local NEOTERM_SUBPKG_ESSENTIAL=false
		local NEOTERM_SUBPKG_BREAKS=""
		local NEOTERM_SUBPKG_DEPENDS=""
		local NEOTERM_SUBPKG_RECOMMENDS=""
		local NEOTERM_SUBPKG_SUGGESTS=""
		local NEOTERM_SUBPKG_CONFLICTS=""
		local NEOTERM_SUBPKG_REPLACES=""
		local NEOTERM_SUBPKG_PROVIDES=""
		local NEOTERM_SUBPKG_CONFFILES=""
		local NEOTERM_SUBPKG_DEPEND_ON_PARENT=""
		local NEOTERM_SUBPKG_EXCLUDED_ARCHES=""
		local SUB_PKG_MASSAGE_DIR=$SUB_PKG_DIR/massage/$NEOTERM_PREFIX_CLASSICAL
		local SUB_PKG_PACKAGE_DIR=$SUB_PKG_DIR/package
		mkdir -p "$SUB_PKG_MASSAGE_DIR" "$SUB_PKG_PACKAGE_DIR"

		# Override neoterm_step_create_subpkg_debscripts
		# shellcheck source=/dev/null
		source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_create_subpkg_debscripts.sh"

		# shellcheck source=/dev/null
		source "$subpackage"

		# Allow globstar (i.e. './**/') patterns.
		shopt -s globstar
		# Allow negation patterns.
		shopt -s extglob
		for includeset in $NEOTERM_SUBPKG_INCLUDE; do
			local _INCLUDE_DIRSET
			_INCLUDE_DIRSET=$(dirname "$includeset")
			test "$_INCLUDE_DIRSET" = "." && _INCLUDE_DIRSET=""

			if [ -e "$includeset" ] || [ -L "$includeset" ]; then
				# Add the -L clause to handle relative symbolic links:
				mkdir -p "$SUB_PKG_MASSAGE_DIR/$_INCLUDE_DIRSET"
				mv "$includeset" "$SUB_PKG_MASSAGE_DIR/$_INCLUDE_DIRSET"
			else
				echo "WARNING: tried to add $includeset to subpackage '$SUB_PKG_NAME', but could not find it"
			fi
		done
		shopt -u globstar extglob

		# Do not create subpackage for specific arches.
		# Using NEOTERM_ARCH instead of SUB_PKG_ARCH (defined below) is intentional.
		if [ "$NEOTERM_SUBPKG_EXCLUDED_ARCHES" != "${NEOTERM_SUBPKG_EXCLUDED_ARCHES/$NEOTERM_ARCH}" ]; then
			echo "Skipping creating subpackage '$SUB_PKG_NAME' for arch $NEOTERM_ARCH"
			continue
		fi

		local SUB_PKG_ARCH=$NEOTERM_ARCH
		[ "$NEOTERM_SUBPKG_PLATFORM_INDEPENDENT" = "true" ] && SUB_PKG_ARCH=all

		cd "$SUB_PKG_DIR/massage"
		# Check that files were actually installed, else don't subpackage.
		if [ "$SUB_PKG_ARCH" = "all" ] && [ "$(find . -type f -print | head -n1)" = "" ]; then
			echo "No files in subpackage '$SUB_PKG_NAME' when built for $SUB_PKG_ARCH with package '$NEOTERM_PKG_NAME', so"
			echo "the subpackage was not created. If unexpected, check to make sure the files are where you expect."
			cd "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX_CLASSICAL"
			continue
		fi
		local SUB_PKG_INSTALLSIZE
		SUB_PKG_INSTALLSIZE=$(du -sk . | cut -f 1)
		tar -cJf "$SUB_PKG_PACKAGE_DIR/data.tar.xz" .

		mkdir -p DEBIAN
		cd DEBIAN

		cat > control <<-HERE
			Package: $SUB_PKG_NAME
			Architecture: ${SUB_PKG_ARCH}
			Installed-Size: ${SUB_PKG_INSTALLSIZE}
			Maintainer: $NEOTERM_PKG_MAINTAINER
			Version: $NEOTERM_PKG_FULLVERSION
			Homepage: $NEOTERM_PKG_HOMEPAGE
		HERE

		local PKG_DEPS_SPC=" ${NEOTERM_PKG_DEPENDS//,/} "

		if [ -z "$NEOTERM_SUBPKG_DEPEND_ON_PARENT" ] && [ "${PKG_DEPS_SPC/ $SUB_PKG_NAME /}" = "$PKG_DEPS_SPC" ]; then
			NEOTERM_SUBPKG_DEPENDS+=", $NEOTERM_PKG_NAME (= $NEOTERM_PKG_FULLVERSION)"
		elif [ "$NEOTERM_SUBPKG_DEPEND_ON_PARENT" = unversioned ]; then
			NEOTERM_SUBPKG_DEPENDS+=", $NEOTERM_PKG_NAME"
		elif [ "$NEOTERM_SUBPKG_DEPEND_ON_PARENT" = deps ]; then
			NEOTERM_SUBPKG_DEPENDS+=", $NEOTERM_PKG_DEPENDS"
		fi

		if [ "$NEOTERM_GLOBAL_LIBRARY" = "true" ] && [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
			test ! -z "$NEOTERM_SUBPKG_DEPENDS" && NEOTERM_SUBPKG_DEPENDS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_SUBPKG_DEPENDS")
			test ! -z "$NEOTERM_SUBPKG_BREAKS" && NEOTERM_SUBPKG_BREAKS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_SUBPKG_BREAKS")
			test ! -z "$NEOTERM_SUBPKG_CONFLICTS" && NEOTERM_SUBPKG_CONFLICTS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_SUBPKG_CONFLICTS")
			test ! -z "$NEOTERM_SUBPKG_RECOMMENDS" && NEOTERM_SUBPKG_RECOMMENDS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_SUBPKG_RECOMMENDS")
			test ! -z "$NEOTERM_SUBPKG_REPLACES" && NEOTERM_SUBPKG_REPLACES=$(package__add_prefix_glibc_to_package_list "$NEOTERM_SUBPKG_REPLACES")
			test ! -z "$NEOTERM_SUBPKG_PROVIDES" && NEOTERM_SUBPKG_PROVIDES=$(package__add_prefix_glibc_to_package_list "$NEOTERM_SUBPKG_PROVIDES")
			test ! -z "$NEOTERM_SUBPKG_SUGGESTS" && NEOTERM_SUBPKG_SUGGESTS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_SUBPKG_SUGGESTS")
		fi

		[ "$NEOTERM_SUBPKG_ESSENTIAL" = "true" ] && echo "Essential: yes" >> control
		test ! -z "$NEOTERM_SUBPKG_DEPENDS" && echo "Depends: ${NEOTERM_SUBPKG_DEPENDS/#, /}" >> control
		test ! -z "$NEOTERM_SUBPKG_BREAKS" && echo "Breaks: $NEOTERM_SUBPKG_BREAKS" >> control
		test ! -z "$NEOTERM_SUBPKG_CONFLICTS" && echo "Conflicts: $NEOTERM_SUBPKG_CONFLICTS" >> control
		test ! -z "$NEOTERM_SUBPKG_RECOMMENDS" && echo "Recommends: $NEOTERM_SUBPKG_RECOMMENDS" >> control
		test ! -z "$NEOTERM_SUBPKG_REPLACES" && echo "Replaces: $NEOTERM_SUBPKG_REPLACES" >> control
		test ! -z "$NEOTERM_SUBPKG_PROVIDES" && echo "Provides: $NEOTERM_SUBPKG_PROVIDES" >> control
		test ! -z "$NEOTERM_SUBPKG_SUGGESTS" && echo "Suggests: $NEOTERM_SUBPKG_SUGGESTS" >> control
		echo "Description: $NEOTERM_SUBPKG_DESCRIPTION" >> control

		for f in $NEOTERM_SUBPKG_CONFFILES; do echo "$NEOTERM_PREFIX_CLASSICAL/$f" >> conffiles; done

		# Allow packages to create arbitrary control files.
		neoterm_step_create_subpkg_debscripts

		# Create control.tar.xz
		tar -cJf "$SUB_PKG_PACKAGE_DIR/control.tar.xz" -H gnu .

		# Create the actual .deb file:
		NEOTERM_SUBPKG_DEBFILE=$NEOTERM_OUTPUT_DIR/${SUB_PKG_NAME}${DEBUG}_${NEOTERM_PKG_FULLVERSION}_${SUB_PKG_ARCH}.deb
		test ! -f "$NEOTERM_COMMON_CACHEDIR/debian-binary" && echo "2.0" > "$NEOTERM_COMMON_CACHEDIR/debian-binary"
		${AR-ar} cr "$NEOTERM_SUBPKG_DEBFILE" \
				   "$NEOTERM_COMMON_CACHEDIR/debian-binary" \
				   "$SUB_PKG_PACKAGE_DIR/control.tar.xz" \
				   "$SUB_PKG_PACKAGE_DIR/data.tar.xz"

		# Go back to main package:
		cd "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX_CLASSICAL"
	done
}
