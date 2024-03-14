neoterm_step_create_pacman_package() {
	local NEOTERM_PKG_INSTALLSIZE
	NEOTERM_PKG_INSTALLSIZE=$(du -bs . | cut -f 1)

	# From here on NEOTERM_ARCH is set to "all" if NEOTERM_PKG_PLATFORM_INDEPENDENT is set by the package
	[ "$NEOTERM_PKG_PLATFORM_INDEPENDENT" = "true" ] && NEOTERM_ARCH=any

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

	local PACMAN_FILE=$NEOTERM_OUTPUT_DIR/${NEOTERM_PKG_NAME}${DEBUG}-${NEOTERM_PKG_FULLVERSION_FOR_PACMAN}-${NEOTERM_ARCH}.pkg.tar.${PKG_FORMAT}

	local BUILD_DATE
	BUILD_DATE=$(date +%s)

	if [ "$NEOTERM_GLOBAL_LIBRARY" = "true" ] && [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
		test ! -z "$NEOTERM_PKG_DEPENDS" && NEOTERM_PKG_DEPENDS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_DEPENDS")
		test ! -z "$NEOTERM_PKG_BREAKS" && NEOTERM_PKG_BREAKS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_BREAKS")
		test ! -z "$NEOTERM_PKG_CONFLICTS" && NEOTERM_PKG_CONFLICTS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_CONFLICTS")
		test ! -z "$NEOTERM_PKG_RECOMMENDS" && NEOTERM_PKG_RECOMMENDS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_RECOMMENDS")
		test ! -z "$NEOTERM_PKG_REPLACES" && NEOTERM_PKG_REPLACES=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_REPLACES")
		test ! -z "$NEOTERM_PKG_PROVIDES" && NEOTERM_PKG_PROVIDES=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_PROVIDES")
		test ! -z "$NEOTERM_PKG_SUGGESTS" && NEOTERM_PKG_SUGGESTS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_SUGGESTS")
	fi

	# Package metadata.
	{
		echo "pkgname = $NEOTERM_PKG_NAME"
		echo "pkgbase = $NEOTERM_PKG_NAME"
		echo "pkgver = $NEOTERM_PKG_FULLVERSION_FOR_PACMAN"
		echo "pkgdesc = $(echo "$NEOTERM_PKG_DESCRIPTION" | tr '\n' ' ')"
		echo "url = $NEOTERM_PKG_HOMEPAGE"
		echo "builddate = $BUILD_DATE"
		echo "packager = $NEOTERM_PKG_MAINTAINER"
		echo "size = $NEOTERM_PKG_INSTALLSIZE"
		echo "arch = $NEOTERM_ARCH"

		if [ -n "$NEOTERM_PKG_LICENSE" ]; then
			tr ',' '\n' <<< "$NEOTERM_PKG_LICENSE" | awk '{ printf "license = %s\n", $0 }'
		fi

		if [ -n "$NEOTERM_PKG_REPLACES" ]; then
			tr ',' '\n' <<< "$NEOTERM_PKG_REPLACES" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "replaces = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }'
		fi

		if [ -n "$NEOTERM_PKG_CONFLICTS" ]; then
			tr ',' '\n' <<< "$NEOTERM_PKG_CONFLICTS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "conflict = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }'
		fi

		if [ -n "$NEOTERM_PKG_BREAKS" ]; then
			tr ',' '\n' <<< "$NEOTERM_PKG_BREAKS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "conflict = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }'
		fi

		if [ -n "$NEOTERM_PKG_PROVIDES" ]; then
			tr ',' '\n' <<< "$NEOTERM_PKG_PROVIDES" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "provides = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }'
		fi

		if [ -n "$NEOTERM_PKG_DEPENDS" ]; then
			tr ',' '\n' <<< "$NEOTERM_PKG_DEPENDS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "depend = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }' | sed 's/|.*//'
		fi

		if [ -n "$NEOTERM_PKG_RECOMMENDS" ]; then
			tr ',' '\n' <<< "$NEOTERM_PKG_RECOMMENDS" | awk '{ printf "optdepend = %s\n", $1 }'
		fi

		if [ -n "$NEOTERM_PKG_SUGGESTS" ]; then
			tr ',' '\n' <<< "$NEOTERM_PKG_SUGGESTS" | awk '{ printf "optdepend = %s\n", $1 }'
		fi

		if [ -n "$NEOTERM_PKG_BUILD_DEPENDS" ]; then
			tr ',' '\n' <<< "$NEOTERM_PKG_BUILD_DEPENDS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "makedepend = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }'
		fi

		if [ -n "$NEOTERM_PKG_CONFFILES" ]; then
			tr ',' '\n' <<< "$NEOTERM_PKG_CONFFILES" | awk '{ printf "backup = '"${NEOTERM_PREFIX_CLASSICAL:1}"'/%s\n", $1 }'
		fi

		if [ -n "$NEOTERM_PKG_GROUPS" ]; then
			tr ',' '\n' <<< "${NEOTERM_PKG_GROUPS/#, /}" | awk '{ printf "group = %s\n", $1 }'
		fi
	} > .PKGINFO

	# Build metadata.
	{
		echo "format = 2"
		echo "pkgname = $NEOTERM_PKG_NAME"
		echo "pkgbase = $NEOTERM_PKG_NAME"
		echo "pkgver = $NEOTERM_PKG_FULLVERSION_FOR_PACMAN"
		echo "pkgarch = $NEOTERM_ARCH"
		echo "packager = $NEOTERM_PKG_MAINTAINER"
		echo "builddate = $BUILD_DATE"
	} > .BUILDINFO

	# Write installation hooks.
	neoterm_step_create_debscripts
	neoterm_step_create_pacman_install_hook

	# Create package
	shopt -s dotglob globstar
	printf '%s\0' **/* | bsdtar -cnf - --format=mtree \
		--options='!all,use-set,type,uid,gid,mode,time,size,md5,sha256,link' \
		--null --files-from - --exclude .MTREE | \
		gzip -c -f -n > .MTREE
	printf '%s\0' **/* | bsdtar --no-fflags -cnf - --null --files-from - | \
		$COMPRESS > "$PACMAN_FILE"
	shopt -u dotglob globstar
}
