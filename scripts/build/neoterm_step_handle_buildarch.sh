neoterm_step_handle_buildarch() {
	[ "$NEOTERM_ON_DEVICE_BUILD" = "true" ] && return

	# If $NEOTERM_PREFIX already exists, it may have been built for a different arch
	local NEOTERM_ARCH_FILE=/data/NEOTERM_ARCH
	if [ -f "${NEOTERM_ARCH_FILE}" ]; then
		local NEOTERM_PREVIOUS_ARCH
		NEOTERM_PREVIOUS_ARCH=$(cat $NEOTERM_ARCH_FILE)
		if [ "$NEOTERM_PREVIOUS_ARCH" != "$NEOTERM_ARCH" ]; then
			local NEOTERM_DATA_BACKUPDIRS=$NEOTERM_TOPDIR/_databackups
			mkdir -p "$NEOTERM_DATA_BACKUPDIRS"
			local NEOTERM_DATA_PREVIOUS_BACKUPDIR=$NEOTERM_DATA_BACKUPDIRS/$NEOTERM_PREVIOUS_ARCH
			local NEOTERM_DATA_CURRENT_BACKUPDIR=$NEOTERM_DATA_BACKUPDIRS/$NEOTERM_ARCH
			# Save current /data (removing old backup if any)
			if test -e "$NEOTERM_DATA_PREVIOUS_BACKUPDIR"; then
				neoterm_error_exit "Directory already exists"
			fi
			if [ -d /data/data ]; then
				mv /data/data "$NEOTERM_DATA_PREVIOUS_BACKUPDIR"
				if [ -d "${NEOTERM_DATA_PREVIOUS_BACKUPDIR}/${NEOTERM_APP_PACKAGE}/cgct" ]; then
					mkdir -p "/data/data/${NEOTERM_APP_PACKAGE}"
					mv "${NEOTERM_DATA_PREVIOUS_BACKUPDIR}/${NEOTERM_APP_PACKAGE}/cgct" "/data/data/${NEOTERM_APP_PACKAGE}"
				fi
			fi
			# Restore new one (if any)
			if [ -d "$NEOTERM_DATA_CURRENT_BACKUPDIR" ]; then
				mv "$NEOTERM_DATA_CURRENT_BACKUPDIR" /data/data
			fi
		fi
	fi

	# Keep track of current arch we are building for.
	echo "$NEOTERM_ARCH" > $NEOTERM_ARCH_FILE
}
