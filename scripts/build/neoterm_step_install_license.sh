neoterm_step_install_license() {
	[ "$NEOTERM_PKG_METAPACKAGE" = "true" ] && return

	mkdir -p "$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME"
	local LICENSE
	local COUNTER=0
	if [ ! "${NEOTERM_PKG_LICENSE_FILE}" = "" ]; then
		INSTALLED_LICENSES=()
		COUNTER=1
		while read -r LICENSE; do
			if [ ! -f "$NEOTERM_PKG_SRCDIR/$LICENSE" ]; then
				neoterm_error_exit "$NEOTERM_PKG_SRCDIR/$LICENSE does not exist"
			fi
			if [[ " ${INSTALLED_LICENSES[@]} " =~ " $(basename $LICENSE) " ]]; then
				# We have already installed a license file named $(basename $LICENSE) so add a suffix to it
				TARGET="$NEOTERM_PREFIX/share/doc/${NEOTERM_PKG_NAME}/$(basename $LICENSE).$COUNTER"
				COUNTER=$((COUNTER + 1))
			else
				TARGET="$NEOTERM_PREFIX/share/doc/${NEOTERM_PKG_NAME}/$(basename $LICENSE)"
				INSTALLED_LICENSES+=("$(basename $LICENSE)")
			fi
			cp -f "${NEOTERM_PKG_SRCDIR}/${LICENSE}" "$TARGET"
		done < <(echo "$NEOTERM_PKG_LICENSE_FILE" | sed "s/,/\n/g")
	else
		local TO_LICENSE
		while read -r LICENSE; do
			# These licenses contain copyright information, so
			# we cannot use a generic license file
			if [ "$LICENSE" == "MIT" ] || \
				[ "$LICENSE" == "ISC" ] || \
				[ "$LICENSE" == "PythonPL" ] || \
				[ "$LICENSE" == "Openfont-1.1" ] || \
				[ "$LICENSE" == "ZLIB" ] || \
				[ "$LICENSE" == "Libpng" ] || \
				[ "$LICENSE" == "BSD" ] || \
				[ "$LICENSE" == "BSD 2-Clause" ] || \
				[ "$LICENSE" == "BSD 3-Clause" ] || \
				[ "$LICENSE" == "X11" ] || \
				[ "$LICENSE" == "curl" ] || \
				[ "$LICENSE" == "BSD Simplified" ]; then
			    for FILE in LICENSE \
                                            LICENSE.md \
                                            LICENSE.txt \
                                            LICENSE.TXT \
                                            COPYING \
                                            COPYRIGHT \
                                            Copyright.txt \
                                            Copyright \
                                            LICENCE \
                                            License \
                                            license \
                                            license.md \
                                            License.txt \
                                            license.txt \
                                            licence; do
					if [ -f "$NEOTERM_PKG_SRCDIR/$FILE" ]; then
						if [[ $COUNTER -gt 0 ]]; then
							cp -f "${NEOTERM_PKG_SRCDIR}/$FILE" "${NEOTERM_PREFIX}/share/doc/${NEOTERM_PKG_NAME}/LICENSE.${COUNTER}"
						else
							cp -f "${NEOTERM_PKG_SRCDIR}/$FILE" "${NEOTERM_PREFIX}/share/doc/${NEOTERM_PKG_NAME}/LICENSE"
						fi
						COUNTER=$((COUNTER + 1))
					fi
				done
			elif [ -f "$NEOTERM_SCRIPTDIR/packages/neoterm-licenses/LICENSES/${LICENSE}.txt" ]; then
				if [ "$NEOTERM_PACKAGE_LIBRARY" = "bionic" ]; then
					TO_LICENSE="../../LICENSES/${LICENSE}.txt"
				elif [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
					TO_LICENSE="../../../../share/LICENSES/${LICENSE}.txt"
				fi
				if [[ $COUNTER -gt 0 ]]; then
					ln -sf "$TO_LICENSE" "$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/LICENSE.${COUNTER}"
				else
					ln -sf "$TO_LICENSE" "$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/LICENSE"
				fi
				COUNTER=$((COUNTER + 1))
			fi
		done < <(echo "$NEOTERM_PKG_LICENSE" | sed "s/,/\n/g")

		for LICENSE in "$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME"/LICENSE*; do
			if [ "$LICENSE" = "$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/LICENSE*" ]; then
				neoterm_error_exit "No LICENSE file was installed for $NEOTERM_PKG_NAME"
			fi
		done
	fi
}
