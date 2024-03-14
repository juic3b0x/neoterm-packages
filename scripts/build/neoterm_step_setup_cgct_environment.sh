# Installing packages if necessary for the full operation of CGCT (main use: not in Termux devices)

neoterm_step_setup_cgct_environment() {
	[ "$NEOTERM_ON_DEVICE_BUILD" = "true" ] && return

	for PKG in gcc-libs-glibc glibc linux-api-headers-glibc; do
		local PKG_DIR=$(ls ${NEOTERM_SCRIPTDIR}/*/${PKG}/build.sh 2> /dev/null || \
			ls ${NEOTERM_SCRIPTDIR}/*/${PKG/-glibc/}/build.sh 2> /dev/null)
		if [ -z "$PKG_DIR" ]; then
			neoterm_error_exit "Could not find build.sh file for package '${PKG}'"
		fi
		local PKG_DIR_SPLIT=(${PKG_DIR//// })

		local REPO_NAME=""
		local LIST_PACKAGES_DIRECTORIES=(${NEOTERM_PACKAGES_DIRECTORIES})
		for idx in ${!LIST_PACKAGES_DIRECTORIES[@]}; do
			if [ "${LIST_PACKAGES_DIRECTORIES[$idx]}" = "${PKG_DIR_SPLIT[-3]}" ]; then
				REPO_NAME=$(echo "${NEOTERM_REPO_URL[$idx]}" | sed -e 's%https://%%g' -e 's%http://%%g' -e 's%/%-%g')
				if [ "$NEOTERM_REPO_PKG_FORMAT" = "debian" ]; then
					REPO_NAME+="-${NEOTERM_REPO_DISTRIBUTION[$idx]}-Release"
				elif [ "$NEOTERM_REPO_PKG_FORMAT" = "pacman" ]; then
					REPO_NAME+="-json"
				fi
				break
			fi
		done
		if [ -z "$REPO_NAME" ]; then
			neoterm_error_exit "Could not find '${PKG_DIR_SPLIT[-3]}' repo"
		fi

		read DEP_ARCH DEP_VERSION DEP_VERSION_PAC <<< $(neoterm_extract_dep_info $PKG "${PKG_DIR/'/build.sh'/}")

		if ! package__is_package_version_built "$PKG" "$DEP_VERSION" && [ ! -f "$NEOTERM_BUILT_PACKAGES_DIRECTORY/$PKG-for-cgct" ]; then
			[ ! "$NEOTERM_QUIET_BUILD" = "true" ] && echo "Installing '${PKG}' for the CGCT tool environment."

			if [ ! -f "${NEOTERM_COMMON_CACHEDIR}-${DEP_ARCH}/${REPO_NAME}" ]; then
				NEOTERM_INSTALL_DEPS=true neoterm_get_repo_files
			fi

			if ! NEOTERM_WITHOUT_DEPVERSION_BINDING=true neoterm_download_deb_pac $PKG $DEP_ARCH $DEP_VERSION $DEP_VERSION_PAC; then
				neoterm_error_exit "Failed to download package '${PKG}'"
			fi

			[ ! "$NEOTERM_QUIET_BUILD" = true ] && echo "extracting $PKG to $NEOTERM_COMMON_CACHEDIR-$DEP_ARCH..."
			(
				cd $NEOTERM_COMMON_CACHEDIR-$DEP_ARCH
				if [ "$NEOTERM_REPO_PKG_FORMAT" = "debian" ]; then
					ar x ${PKG}_${DEP_VERSION}_${DEP_ARCH}.deb data.tar.xz
					if tar -tf data.tar.xz|grep "^./$">/dev/null; then
						tar -xf data.tar.xz --strip-components=1 \
							--no-overwrite-dir -C /
					else
						tar -xf data.tar.xz --no-overwrite-dir -C /
					fi
				elif [ "$NEOTERM_REPO_PKG_FORMAT" = "pacman" ]; then
					tar -xJf "${PKG}-${DEP_VERSION_PAC}-${DEP_ARCH}.pkg.tar.xz" \
						--force-local --no-overwrite-dir -C / data
				fi
			)
			mkdir -p $NEOTERM_BUILT_PACKAGES_DIRECTORY
			echo "" > "$NEOTERM_BUILT_PACKAGES_DIRECTORY/$PKG-for-cgct"
		fi
	done
}
