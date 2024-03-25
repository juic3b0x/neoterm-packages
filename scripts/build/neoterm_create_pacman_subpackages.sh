neoterm_create_pacman_subpackages() {
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
		local NEOTERM_SUBPKG_GROUPS=""
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
		for includeset in $NEOTERM_SUBPKG_INCLUDE; do
			local _INCLUDE_DIRSET
			_INCLUDE_DIRSET=$(dirname "$includeset")
			test "$_INCLUDE_DIRSET" = "." && _INCLUDE_DIRSET=""

			if [ -e "$includeset" ] || [ -L "$includeset" ]; then
				# Add the -L clause to handle relative symbolic links:
				mkdir -p "$SUB_PKG_MASSAGE_DIR/$_INCLUDE_DIRSET"
				mv "$includeset" "$SUB_PKG_MASSAGE_DIR/$_INCLUDE_DIRSET"
			fi
		done
		shopt -u globstar

		# Do not create subpackage for specific arches.
		# Using NEOTERM_ARCH instead of SUB_PKG_ARCH (defined below) is intentional.
		if [ "$NEOTERM_SUBPKG_EXCLUDED_ARCHES" != "${NEOTERM_SUBPKG_EXCLUDED_ARCHES/$NEOTERM_ARCH}" ]; then
			echo "Skipping creating subpackage '$SUB_PKG_NAME' for arch $NEOTERM_ARCH"
			continue
		fi

		local SUB_PKG_ARCH=$NEOTERM_ARCH
		[ "$NEOTERM_SUBPKG_PLATFORM_INDEPENDENT" = "true" ] && SUB_PKG_ARCH=any

		cd "$SUB_PKG_DIR/massage"
		# Check that files were actually installed, else don't subpackage.
		if [ "$SUB_PKG_ARCH" = "any" ] && [ "$(find . -type f -print | head -n1)" = "" ]; then
			echo "No files in subpackage '$SUB_PKG_NAME' when built for $SUB_PKG_ARCH with package '$NEOTERM_PKG_NAME', so"
			echo "the subpackage was not created. If unexpected, check to make sure the files are where you expect."
			cd "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX_CLASSICAL"
			continue
		fi
		local SUB_PKG_INSTALLSIZE
		SUB_PKG_INSTALLSIZE=$(du -bs . | cut -f 1)

		local BUILD_DATE
		BUILD_DATE=$(date +%s)

		local PKG_DEPS_SPC=" ${NEOTERM_PKG_DEPENDS//,/} "
		if [ -z "$NEOTERM_SUBPKG_DEPEND_ON_PARENT" ] && [ "${PKG_DEPS_SPC/ $SUB_PKG_NAME /}" = "$PKG_DEPS_SPC" ]; then
			# Does pacman supports versioned dependencies?
			#NEOTERM_SUBPKG_DEPENDS+=", $NEOTERM_PKG_NAME (= $NEOTERM_PKG_FULLVERSION)"
			NEOTERM_SUBPKG_DEPENDS+=", $NEOTERM_PKG_NAME"
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

		# Package metadata.
		{
			echo "pkgname = $SUB_PKG_NAME"
			echo "pkgbase = $NEOTERM_PKG_NAME"
			echo "pkgver = $NEOTERM_PKG_FULLVERSION_FOR_PACMAN"
			echo "pkgdesc = $(echo "$NEOTERM_SUBPKG_DESCRIPTION" | tr '\n' ' ')"
			echo "url = $NEOTERM_PKG_HOMEPAGE"
			echo "builddate = $BUILD_DATE"
			echo "packager = $NEOTERM_PKG_MAINTAINER"
			echo "size = $SUB_PKG_INSTALLSIZE"
			echo "arch = $SUB_PKG_ARCH"

			if [ -n "$NEOTERM_SUBPKG_REPLACES" ]; then
				tr ',' '\n' <<< "$NEOTERM_SUBPKG_REPLACES" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "replaces = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }'
			fi

			if [ -n "$NEOTERM_SUBPKG_CONFLICTS" ]; then
				tr ',' '\n' <<< "$NEOTERM_SUBPKG_CONFLICTS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "conflict = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }'
			fi

			if [ -n "$NEOTERM_SUBPKG_BREAKS" ]; then
				tr ',' '\n' <<< "$NEOTERM_SUBPKG_BREAKS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "conflict = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }'
			fi

			if [ -n "$NEOTERM_SUBPKG_PROVIDES" ]; then
				tr ',' '\n' <<< "$NEOTERM_SUBPKG_REPLACES" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "provides = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }'
			fi

			if [ -n "$NEOTERM_SUBPKG_DEPENDS" ]; then
				tr ',' '\n' <<< "${NEOTERM_SUBPKG_DEPENDS/#, /}" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "depend = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }' | sed 's/|.*//'
			fi

			if [ -n "$NEOTERM_SUBPKG_RECOMMENDS" ]; then
				tr ',' '\n' <<< "$NEOTERM_SUBPKG_RECOMMENDS" | awk '{ printf "optdepend = %s\n", $1 }'
			fi

			if [ -n "$NEOTERM_SUBPKG_SUGGESTS" ]; then
				tr ',' '\n' <<< "$NEOTERM_SUBPKG_SUGGESTS" | awk '{ printf "optdepend = %s\n", $1 }'
			fi

			if [ -n "$NEOTERM_SUBPKG_CONFFILES" ]; then
				tr ',' '\n' <<< "$NEOTERM_SUBPKG_CONFFILES" | awk '{ printf "backup = '"${NEOTERM_PREFIX_CLASSICAL:1}"'/%s\n", $1 }'
			fi

			if [ -n "$NEOTERM_SUBPKG_GROUPS" ]; then
				tr ',' '\n' <<< "${NEOTERM_SUBPKG_GROUPS/#, /}" | awk '{ printf "group = %s\n", $1 }'
			fi
		} > .PKGINFO

		# Build metadata.
		{
			echo "format = 2"
			echo "pkgname = $SUB_PKG_NAME"
			echo "pkgbase = $NEOTERM_PKG_NAME"
			echo "pkgver = $NEOTERM_PKG_FULLVERSION_FOR_PACMAN"
			echo "pkgarch = $SUB_PKG_ARCH"
			echo "packager = $NEOTERM_PKG_MAINTAINER"
			echo "builddate = $BUILD_DATE"
		} > .BUILDINFO

		# Write package installation hooks.
		neoterm_step_create_subpkg_debscripts
		neoterm_step_create_pacman_install_hook

		# Configuring the selection of a copress for a batch.
		local COMPRESS
		local PKG_FORMAT
		case $NEOTERM_PACMAN_PACKAGE_COMPRESSION in
			"gzip")
				COMPRESS=(gzip -c -f -n)
				PKG_FORMAT="gz";;
			"bzip2")
				COMPRESS=(bzip2 -c -f)
				PKG_FORMAT="bz2";;
			"zstd")
				COMPRESS=(zstd -c -z -q -)
				PKG_FORMAT="zst";;
			"lrzip")
				COMPRESS=(lrzip -q)
				PKG_FORMAT="lrz";;
			"lzop")
				COMPRESS=(lzop -q)
				PKG_FORMAT="lzop";;
			"lz4")
				COMPRESS=(lz4 -q)
				PKG_FORMAT="lz4";;
			"lzip")
				COMPRESS=(lzip -c -f)
				PKG_FORMAT="lz";;
			"xz" | *)
				COMPRESS=(xz -c -z -)
				PKG_FORMAT="xz";;
		esac

		# Create the actual .pkg file:
		local NEOTERM_SUBPKG_PACMAN_FILE=$NEOTERM_OUTPUT_DIR/${SUB_PKG_NAME}${DEBUG}-${NEOTERM_PKG_FULLVERSION_FOR_PACMAN}-${SUB_PKG_ARCH}.pkg.tar.${PKG_FORMAT}
		shopt -s dotglob globstar
		printf '%s\0' **/* | bsdtar -cnf - --format=mtree \
			--options='!all,use-set,type,uid,gid,mode,time,size,md5,sha256,link' \
			--null --files-from - --exclude .MTREE | \
			gzip -c -f -n > .MTREE
		printf '%s\0' **/* | bsdtar --no-fflags -cnf - --null --files-from - | \
			$COMPRESS > "$NEOTERM_SUBPKG_PACMAN_FILE"
		shopt -u dotglob globstar

		# Go back to main package:
		cd "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX_CLASSICAL"
	done
}
