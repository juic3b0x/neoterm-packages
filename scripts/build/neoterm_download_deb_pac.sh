#!/usr/bin/bash

neoterm_download_deb_pac() {
	local PACKAGE=$1
	local PACKAGE_ARCH=$2
	local VERSION=$3
	local VERSION_PACMAN=$4

	local PKG_FILE
	if [ "$NEOTERM_REPO_PKG_FORMAT" = "debian" ]; then
		PKG_FILE="${PACKAGE}_${VERSION}_${PACKAGE_ARCH}.deb"
	elif [ "$NEOTERM_REPO_PKG_FORMAT" = "pacman" ]; then
		PKG_FILE="${PACKAGE}-${VERSION_PACMAN}-${PACKAGE_ARCH}.pkg.tar.xz"
	fi
	PKG_HASH=""

	# Dependencies should be used from repo only if they are built for
	# same package name.
	# The data.tar.xz extraction by neoterm_step_get_dependencies would
	# extract files to different prefix than NEOTERM_PREFIX and builds
	# would fail when looking for -I$NEOTERM_PREFIX/include files.
	if [ "$NEOTERM_REPO_PACKAGE" != "$NEOTERM_APP_PACKAGE" ]; then
		echo "Ignoring download of $PKG_FILE since repo package name ($NEOTERM_REPO_PACKAGE) does not equal app package name ($NEOTERM_APP_PACKAGE)"
		return 1
	fi

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ]; then
		case "$NEOTERM_APP_PACKAGE_MANAGER" in
			"apt") apt install -y "${PACKAGE}$(test ${NEOTERM_WITHOUT_DEPVERSION_BINDING} != true && echo "=${VERSION}")";;
			"pacman") pacman -S "${PACKAGE}$(test ${NEOTERM_WITHOUT_DEPVERSION_BINDING} != true && echo "=${VERSION_PACMAN}")" --needed --noconfirm;;
		esac
		return "$?"
	fi

	for idx in $(seq ${#NEOTERM_REPO_URL[@]}); do
		local NEOTERM_REPO_NAME=$(echo ${NEOTERM_REPO_URL[$idx-1]} | sed -e 's%https://%%g' -e 's%http://%%g' -e 's%/%-%g')
		if [ "$NEOTERM_REPO_PKG_FORMAT" = "debian" ]; then
			local PACKAGE_FILE_PATH="${NEOTERM_REPO_NAME}-${NEOTERM_REPO_DISTRIBUTION[$idx-1]}-${NEOTERM_REPO_COMPONENT[$idx-1]}-Packages"
		elif [ "$NEOTERM_REPO_PKG_FORMAT" = "pacman" ]; then
			local PACKAGE_FILE_PATH="${NEOTERM_REPO_NAME}-json"
		fi
		if [ "${PACKAGE_ARCH}" = 'all' ]; then
			for arch in 'aarch64' 'arm' 'i686' 'x86_64'; do
				if [ -f "${NEOTERM_COMMON_CACHEDIR}-${arch}/${PACKAGE_FILE_PATH}" ]; then
					if [ "$NEOTERM_REPO_PKG_FORMAT" = "debian" ]; then
						read -d "\n" PKG_PATH PKG_HASH <<<$(./scripts/get_hash_from_file.py "${NEOTERM_COMMON_CACHEDIR}-${arch}/$PACKAGE_FILE_PATH" $PACKAGE $VERSION)
					elif [ "$NEOTERM_REPO_PKG_FORMAT" = "pacman" ]; then
						if [ "$NEOTERM_WITHOUT_DEPVERSION_BINDING" = "true" ] || [ $(jq -r '."'$PACKAGE'"."VERSION"' "${NEOTERM_COMMON_CACHEDIR}-${arch}/$PACKAGE_FILE_PATH") = "${VERSION_PACMAN}" ]; then
							PKG_HASH=$(jq -r '."'$PACKAGE'"."SHA256SUM"' "${NEOTERM_COMMON_CACHEDIR}-${arch}/$PACKAGE_FILE_PATH")
							PKG_PATH=$(jq -r '."'$PACKAGE'"."FILENAME"' "${NEOTERM_COMMON_CACHEDIR}-${arch}/$PACKAGE_FILE_PATH")
							PKG_PATH="${arch}/${PKG_PATH}"
						fi
					fi
					if [ -n "$PKG_HASH" ] && [ "$PKG_HASH" != "null" ]; then
						if [ ! "$NEOTERM_QUIET_BUILD" = true ]; then
							if [ "$NEOTERM_REPO_PKG_FORMAT" = "debian" ]; then
								echo "Found $PACKAGE in ${NEOTERM_REPO_URL[$idx-1]}/dists/${NEOTERM_REPO_DISTRIBUTION[$idx-1]}"
							elif [ "$NEOTERM_REPO_PKG_FORMAT" = "pacman" ]; then
								echo "Found $PACKAGE in ${NEOTERM_REPO_URL[$idx-1]}"
							fi
						fi
						break 2
					fi
				fi
			done
		elif [ ! -f "${NEOTERM_COMMON_CACHEDIR}-${PACKAGE_ARCH}/${PACKAGE_FILE_PATH}" ] && \
			[ -f "${NEOTERM_COMMON_CACHEDIR}-aarch64/${PACKAGE_FILE_PATH}" ]; then
			# Packages file for $PACKAGE_ARCH did not
			# exist. Could be an aptly mirror where the
			# all arch is mixed into the other arches,
			# check for package in aarch64 Packages
			# instead.
			if [ "$NEOTERM_REPO_PKG_FORMAT" = "debian" ]; then
				read -d "\n" PKG_PATH PKG_HASH <<<$(./scripts/get_hash_from_file.py "${NEOTERM_COMMON_CACHEDIR}-aarch64/$PACKAGE_FILE_PATH" $PACKAGE $VERSION)
			elif [ "$NEOTERM_REPO_PKG_FORMAT" = "pacman" ]; then
				if [ "$NEOTERM_WITHOUT_DEPVERSION_BINDING" = "true" ] || [ $(jq -r '."'$PACKAGE'"."VERSION"' "${NEOTERM_COMMON_CACHEDIR}-aarch64/$PACKAGE_FILE_PATH") = "${VERSION_PACMAN}"]; then
					PKG_HASH=$(jq -r '."'$PACKAGE'"."SHA256SUM"' "${NEOTERM_COMMON_CACHEDIR}-aarch64/$PACKAGE_FILE_PATH")
					PKG_PATH=$(jq -r '."'$PACKAGE'"."FILENAME"' "${NEOTERM_COMMON_CACHEDIR}-aarch64/$PACKAGE_FILE_PATH")
					PKG_PATH="aarch64/${PKG_PATH}"
				fi
			fi
			if [ -n "$PKG_HASH" ] && [ "$PKG_HASH" != "null" ]; then
				if [ ! "$NEOTERM_QUIET_BUILD" = true ]; then
					if [ "$NEOTERM_REPO_PKG_FORMAT" = "debian" ]; then
						echo "Found $PACKAGE in ${NEOTERM_REPO_URL[$idx-1]}/dists/${NEOTERM_REPO_DISTRIBUTION[$idx-1]}"
					elif [ "$NEOTERM_REPO_PKG_FORMAT" = "pacman" ]; then
						echo "Found $PACKAGE in ${NEOTERM_REPO_URL[$idx-1]}"
					fi
				fi
				break
			fi
		elif [ -f "${NEOTERM_COMMON_CACHEDIR}-${PACKAGE_ARCH}/${PACKAGE_FILE_PATH}" ]; then
			if [ "$NEOTERM_REPO_PKG_FORMAT" = "debian" ]; then
				read -d "\n" PKG_PATH PKG_HASH <<<$(./scripts/get_hash_from_file.py "${NEOTERM_COMMON_CACHEDIR}-${PACKAGE_ARCH}/$PACKAGE_FILE_PATH" $PACKAGE $VERSION)
			elif [ "$NEOTERM_REPO_PKG_FORMAT" = "pacman" ]; then
				if [ "$NEOTERM_WITHOUT_DEPVERSION_BINDING" = "true" ] || [ $(jq -r '."'$PACKAGE'"."VERSION"' "${NEOTERM_COMMON_CACHEDIR}-${PACKAGE_ARCH}/$PACKAGE_FILE_PATH") = "${VERSION_PACMAN}" ]; then
					PKG_HASH=$(jq -r '."'$PACKAGE'"."SHA256SUM"' "${NEOTERM_COMMON_CACHEDIR}-${PACKAGE_ARCH}/$PACKAGE_FILE_PATH")
					PKG_PATH=$(jq -r '."'$PACKAGE'"."FILENAME"' "${NEOTERM_COMMON_CACHEDIR}-${PACKAGE_ARCH}/$PACKAGE_FILE_PATH")
					PKG_PATH="${PACKAGE_ARCH}/${PKG_PATH}"
				fi
			fi
			if [ -n "$PKG_HASH" ] && [ "$PKG_HASH" != "null" ]; then
				if [ ! "$NEOTERM_QUIET_BUILD" = true ]; then
					if [ "$NEOTERM_REPO_PKG_FORMAT" = "debian" ]; then
						echo "Found $PACKAGE in ${NEOTERM_REPO_URL[$idx-1]}/dists/${NEOTERM_REPO_DISTRIBUTION[$idx-1]}"
					elif [ "$NEOTERM_REPO_PKG_FORMAT" = "pacman" ]; then
						echo "Found $PACKAGE in ${NEOTERM_REPO_URL[$idx-1]}"
					fi
				fi
				break
			fi
		fi
	done

	if [ "$PKG_HASH" = "" ] || [ "$PKG_HASH" = "null" ]; then
		return 1
	fi

	neoterm_download "${NEOTERM_REPO_URL[${idx}-1]}/${PKG_PATH}" \
				"${NEOTERM_COMMON_CACHEDIR}-${PACKAGE_ARCH}/${PKG_FILE}" \
				"$PKG_HASH"
}

# Make script standalone executable as well as sourceable
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	neoterm_download "$@"
fi
