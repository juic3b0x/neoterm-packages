neoterm_step_create_debian_package() {
	if [ "$NEOTERM_PKG_METAPACKAGE" = "true" ]; then
		# Metapackage doesn't have data inside.
		rm -rf data
	fi
        tar -cJf "$NEOTERM_PKG_PACKAGEDIR/data.tar.xz" -H gnu .

	# Get install size. This will be written as the "Installed-Size" deb field so is measured in 1024-byte blocks:
	local NEOTERM_PKG_INSTALLSIZE
	NEOTERM_PKG_INSTALLSIZE=$(du -sk . | cut -f 1)

	# From here on NEOTERM_ARCH is set to "all" if NEOTERM_PKG_PLATFORM_INDEPENDENT is set by the package
	[ "$NEOTERM_PKG_PLATFORM_INDEPENDENT" = "true" ] && NEOTERM_ARCH=all

	mkdir -p DEBIAN
	cat > DEBIAN/control <<-HERE
		Package: $NEOTERM_PKG_NAME
		Architecture: ${NEOTERM_ARCH}
		Installed-Size: ${NEOTERM_PKG_INSTALLSIZE}
		Maintainer: $NEOTERM_PKG_MAINTAINER
		Version: $NEOTERM_PKG_FULLVERSION
		Homepage: $NEOTERM_PKG_HOMEPAGE
	HERE
	if [ "$NEOTERM_GLOBAL_LIBRARY" = "true" ] && [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
		test ! -z "$NEOTERM_PKG_DEPENDS" && NEOTERM_PKG_DEPENDS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_DEPENDS")
		test ! -z "$NEOTERM_PKG_BREAKS" && NEOTERM_PKG_BREAKS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_BREAKS")
		test ! -z "$NEOTERM_PKG_CONFLICTS" && NEOTERM_PKG_CONFLICTS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_CONFLICTS")
		test ! -z "$NEOTERM_PKG_RECOMMENDS" && NEOTERM_PKG_RECOMMENDS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_RECOMMENDS")
		test ! -z "$NEOTERM_PKG_REPLACES" && NEOTERM_PKG_REPLACES=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_REPLACES")
		test ! -z "$NEOTERM_PKG_PROVIDES" && NEOTERM_PKG_PROVIDES=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_PROVIDES")
		test ! -z "$NEOTERM_PKG_SUGGESTS" && NEOTERM_PKG_SUGGESTS=$(package__add_prefix_glibc_to_package_list "$NEOTERM_PKG_SUGGESTS")
	fi
	test ! -z "$NEOTERM_PKG_BREAKS" && echo "Breaks: $NEOTERM_PKG_BREAKS" >> DEBIAN/control
	test ! -z "$NEOTERM_PKG_PRE_DEPENDS" && echo "Pre-Depends: $NEOTERM_PKG_PRE_DEPENDS" >> DEBIAN/control
	test ! -z "$NEOTERM_PKG_DEPENDS" && echo "Depends: $NEOTERM_PKG_DEPENDS" >> DEBIAN/control
	[ "$NEOTERM_PKG_ESSENTIAL" = "true" ] && echo "Essential: yes" >> DEBIAN/control
	test ! -z "$NEOTERM_PKG_CONFLICTS" && echo "Conflicts: $NEOTERM_PKG_CONFLICTS" >> DEBIAN/control
	test ! -z "$NEOTERM_PKG_RECOMMENDS" && echo "Recommends: $NEOTERM_PKG_RECOMMENDS" >> DEBIAN/control
	test ! -z "$NEOTERM_PKG_REPLACES" && echo "Replaces: $NEOTERM_PKG_REPLACES" >> DEBIAN/control
	test ! -z "$NEOTERM_PKG_PROVIDES" && echo "Provides: $NEOTERM_PKG_PROVIDES" >> DEBIAN/control
	test ! -z "$NEOTERM_PKG_SUGGESTS" && echo "Suggests: $NEOTERM_PKG_SUGGESTS" >> DEBIAN/control
	echo "Description: $NEOTERM_PKG_DESCRIPTION" >> DEBIAN/control

	# Create DEBIAN/conffiles (see https://www.debian.org/doc/debian-policy/ap-pkg-conffiles.html):
	for f in $NEOTERM_PKG_CONFFILES; do echo "$NEOTERM_PREFIX_CLASSICAL/$f" >> DEBIAN/conffiles; done

	# Allow packages to create arbitrary control files.
	# XXX: Should be done in a better way without a function?
	cd DEBIAN
	neoterm_step_create_debscripts

	# Create control.tar.xz
	tar -cJf "$NEOTERM_PKG_PACKAGEDIR/control.tar.xz" -H gnu .

	test ! -f "$NEOTERM_COMMON_CACHEDIR/debian-binary" && echo "2.0" > "$NEOTERM_COMMON_CACHEDIR/debian-binary"
	NEOTERM_PKG_DEBFILE=$NEOTERM_OUTPUT_DIR/${NEOTERM_PKG_NAME}${DEBUG}_${NEOTERM_PKG_FULLVERSION}_${NEOTERM_ARCH}.deb
	# Create the actual .deb file:
	${AR-ar} cr "$NEOTERM_PKG_DEBFILE" \
	       "$NEOTERM_COMMON_CACHEDIR/debian-binary" \
	       "$NEOTERM_PKG_PACKAGEDIR/control.tar.xz" \
	       "$NEOTERM_PKG_PACKAGEDIR/data.tar.xz"
}
