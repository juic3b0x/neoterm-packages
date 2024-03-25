NEOTERM_PKG_HOMEPAGE=https://docbook.org/
NEOTERM_PKG_DESCRIPTION="XML stylesheets for Docbook-xml transformations"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.79.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_LICENSE_FILE="docbook-xsl-${NEOTERM_PKG_VERSION}/COPYING, docbook-xsl-nons-${NEOTERM_PKG_VERSION}/COPYING"
NEOTERM_PKG_DEPENDS="docbook-xml, libxml2-utils, xsltproc"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_SKIP_SRC_EXTRACT=true

neoterm_step_get_source() {
	mkdir -p $NEOTERM_PKG_SRCDIR

	cd $NEOTERM_PKG_SRCDIR

	neoterm_download "https://github.com/docbook/xslt10-stylesheets/releases/download/release%2F${NEOTERM_PKG_VERSION}/docbook-xsl-$NEOTERM_PKG_VERSION.tar.gz" \
		$NEOTERM_PKG_CACHEDIR/docbook-xsl-$NEOTERM_PKG_VERSION.tar.gz \
		966188d7c05fc76eaca115a55893e643dd01a3486f6368733c9ad974fcee7a26

	tar xf $NEOTERM_PKG_CACHEDIR/docbook-xsl-$NEOTERM_PKG_VERSION.tar.gz

	neoterm_download "https://github.com/docbook/xslt10-stylesheets/releases/download/release%2F${NEOTERM_PKG_VERSION}/docbook-xsl-nons-$NEOTERM_PKG_VERSION.tar.gz" \
		$NEOTERM_PKG_CACHEDIR/docbook-xsl-nons-$NEOTERM_PKG_VERSION.tar.gz \
		f89425b44e48aad24319a2f0d38e0cb6059fdc7dbaf31787c8346c748175ca8e

	tar xf $NEOTERM_PKG_CACHEDIR/docbook-xsl-nons-$NEOTERM_PKG_VERSION.tar.gz
}

neoterm_step_patch_package() {
	cd $NEOTERM_PKG_SRCDIR/docbook-xsl-$NEOTERM_PKG_VERSION
	patch -Np2 -i $NEOTERM_PKG_BUILDER_DIR/765567_non-recursive_string_subst.patch

	cd $NEOTERM_PKG_SRCDIR/docbook-xsl-nons-$NEOTERM_PKG_VERSION
	patch -Np2 -i $NEOTERM_PKG_BUILDER_DIR/765567_non-recursive_string_subst.patch
}

neoterm_step_make_install() {
	local pkgroot ns dir

	for ns in -nons ''; do
		pkgroot="$NEOTERM_PREFIX/share/xml/docbook/xsl-stylesheets-${NEOTERM_PKG_VERSION}${ns}"
		dir=docbook-xsl${ns}-${NEOTERM_PKG_VERSION}

		install -Dt "$pkgroot" -m600 $dir/VERSION{,.xsl}

		(
			shopt -s nullglob  # ignore missing files
			for fn in assembly common eclipse epub epub3 fo highlighting html \
				htmlhelp javahelp lib manpages params profiling roundtrip template \
				website xhtml xhtml-1_1 xhtml5
			do
				install -Dt "${pkgroot}/${fn}" -m600 ${dir}/${fn}/*.{xml,xsl,dtd,ent}
			done
		)
	done
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ]; then
		if [ ! -e "$NEOTERM_PREFIX/etc/xml/catalog" ]; then
			xmlcatalog --noout --create "$NEOTERM_PREFIX/etc/xml/catalog"
		else
			xmlcatalog --noout --del "$NEOTERM_PREFIX/share/xml/docbook/xsl-stylesheets-$NEOTERM_PKG_VERSION" \
				"$NEOTERM_PREFIX/etc/xml/catalog"
		fi

		for ver in $NEOTERM_PKG_VERSION current; do
			for x in rewriteSystem rewriteURI; do
				xmlcatalog --noout --add \$x http://cdn.docbook.org/release/xsl/\$ver \
					"$NEOTERM_PREFIX/share/xml/docbook/xsl-stylesheets-$NEOTERM_PKG_VERSION" \
					"$NEOTERM_PREFIX/etc/xml/catalog"

				xmlcatalog --noout --add \$x http://docbook.sourceforge.net/release/xsl-ns/\$ver \
					"$NEOTERM_PREFIX/share/xml/docbook/xsl-stylesheets-$NEOTERM_PKG_VERSION" \
					"$NEOTERM_PREFIX/etc/xml/catalog"

				xmlcatalog --noout --add \$x http://docbook.sourceforge.net/release/xsl/\$ver \
					"$NEOTERM_PREFIX/share/xml/docbook/xsl-stylesheets-${NEOTERM_PKG_VERSION}-nons" \
					"$NEOTERM_PREFIX/etc/xml/catalog"
			done
		done
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "remove" ]; then
		xmlcatalog --noout --del "$NEOTERM_PREFIX/share/xml/docbook/xsl-stylesheets-$NEOTERM_PKG_VERSION" \
			"$NEOTERM_PREFIX/etc/xml/catalog"
	fi
	EOF
}
