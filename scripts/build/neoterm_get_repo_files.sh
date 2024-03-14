neoterm_get_repo_files() {
	# Not needed for on-device builds or when building
	# dependencies.
	if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ] || [ "$NEOTERM_INSTALL_DEPS" = "false" ]; then
		return
	fi

	for idx in $(seq ${#NEOTERM_REPO_URL[@]}); do
		local NEOTERM_REPO_NAME=$(echo ${NEOTERM_REPO_URL[$idx-1]} | sed -e 's%https://%%g' -e 's%http://%%g' -e 's%/%-%g')
		if [ "$NEOTERM_REPO_PKG_FORMAT" = "debian" ]; then
			local RELEASE_FILE=${NEOTERM_COMMON_CACHEDIR}/${NEOTERM_REPO_NAME}-${NEOTERM_REPO_DISTRIBUTION[$idx-1]}-Release
			local repo_base="${NEOTERM_REPO_URL[$idx-1]}/dists/${NEOTERM_REPO_DISTRIBUTION[$idx-1]}"
			local dl_prefix="${NEOTERM_REPO_NAME}-${NEOTERM_REPO_DISTRIBUTION[$idx-1]}-${NEOTERM_REPO_COMPONENT[$idx-1]}"
		elif [ "$NEOTERM_REPO_PKG_FORMAT" = "pacman" ]; then
			local JSON_FILE="${NEOTERM_COMMON_CACHEDIR}-${NEOTERM_ARCH}/${NEOTERM_REPO_NAME}-json"
			local repo_base="${NEOTERM_REPO_URL[$idx-1]}/${NEOTERM_ARCH}"
		fi

		local download_attempts=6
		while ((download_attempts > 0)); do
			if [ "$NEOTERM_REPO_PKG_FORMAT" = "debian" ]; then
				if neoterm_download "${repo_base}/Release" "$RELEASE_FILE" SKIP_CHECKSUM && \
					neoterm_download "${repo_base}/Release.gpg" "${RELEASE_FILE}.gpg" SKIP_CHECKSUM && \
					gpg --verify "${RELEASE_FILE}.gpg" "$RELEASE_FILE"; then

					local failed=false
					for arch in all $NEOTERM_ARCH; do
						local PACKAGES_HASH=$(./scripts/get_hash_from_file.py ${RELEASE_FILE} $arch ${NEOTERM_REPO_COMPONENT[$idx-1]})

						# If packages_hash = "" then the repo probably doesn't contain debs for $arch
						if [ -n "$PACKAGES_HASH" ]; then
							if ! neoterm_download "${repo_base}/${NEOTERM_REPO_COMPONENT[$idx-1]}/binary-$arch/Packages" \
								"${NEOTERM_COMMON_CACHEDIR}-$arch/${dl_prefix}-Packages" \
								$PACKAGES_HASH; then
								failed=true
								break
							fi
						fi
					done

					if ! $failed; then
						break
					fi
				fi
			elif [ "$NEOTERM_REPO_PKG_FORMAT" = "pacman" ]; then
				if neoterm_download "${repo_base}/${NEOTERM_REPO_DISTRIBUTION[$idx-1]}.json" "$JSON_FILE" SKIP_CHECKSUM && \
					neoterm_download "${repo_base}/${NEOTERM_REPO_DISTRIBUTION[$idx-1]}.json.sig" "${JSON_FILE}.sig" SKIP_CHECKSUM && \
					gpg --verify "${JSON_FILE}.sig" "$JSON_FILE"; then

					break
				fi
			fi

			download_attempts=$((download_attempts - 1))
			if ((download_attempts < 1)); then
				neoterm_error_exit "Failed to download package repository metadata. Try to build without -i/-I option."
			fi

			echo "Retrying download in 30 seconds (${download_attempts} attempts left)..." >&2
			sleep 30
		done

	done
}
