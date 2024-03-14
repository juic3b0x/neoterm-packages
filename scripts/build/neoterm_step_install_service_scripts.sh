neoterm_step_install_service_scripts() {
	array_length=${#NEOTERM_PKG_SERVICE_SCRIPT[@]}
	if [ $array_length -eq 0 ]; then return; fi

	# NEOTERM_PKG_SERVICE_SCRIPT should have the structure =("daemon name" 'script to execute')
	if [ $(( $array_length & 1 )) -eq 1 ]; then
		neoterm_error_exit "NEOTERM_PKG_SERVICE_SCRIPT has to be an array of even length"
	fi

	mkdir -p $NEOTERM_PREFIX/var/service
	cd $NEOTERM_PREFIX/var/service
	for ((i=0; i<${array_length}; i+=2)); do
		mkdir -p ${NEOTERM_PKG_SERVICE_SCRIPT[$i]}
		# We unlink ${NEOTERM_PKG_SERVICE_SCRIPT[$i]}/run if it exists to
		# allow it to be overwritten through NEOTERM_PKG_SERVICE_SCRIPT
		if [ -L "${NEOTERM_PKG_SERVICE_SCRIPT[$i]}/run" ]; then
			unlink "${NEOTERM_PKG_SERVICE_SCRIPT[$i]}/run"
		fi
		echo "#!$NEOTERM_PREFIX/bin/sh" > ${NEOTERM_PKG_SERVICE_SCRIPT[$i]}/run
		echo -e ${NEOTERM_PKG_SERVICE_SCRIPT[$((i + 1))]} >> ${NEOTERM_PKG_SERVICE_SCRIPT[$i]}/run

		# Do not add service script to CONFFILES if it already exists there
		if [[ $NEOTERM_PKG_CONFFILES != *${NEOTERM_PKG_SERVICE_SCRIPT[$i]}/run* ]]; then
			NEOTERM_PKG_CONFFILES+=" var/service/${NEOTERM_PKG_SERVICE_SCRIPT[$i]}/run"
		fi

		chmod +x ${NEOTERM_PKG_SERVICE_SCRIPT[$i]}/run

		# Avoid creating service/<service>/log/log/
		if [ "${NEOTERM_PKG_SERVICE_SCRIPT[$i]: -4}" != "/log" ]; then
			touch ${NEOTERM_PKG_SERVICE_SCRIPT[$i]}/down
			NEOTERM_PKG_CONFFILES+=" var/service/${NEOTERM_PKG_SERVICE_SCRIPT[$i]}/down"
			local _log_run=${NEOTERM_PKG_SERVICE_SCRIPT[$i]}/log/run
			rm -rf "${_log_run}"
			mkdir -p "$(dirname "${_log_run}")"
			cat <<-EOF > "${_log_run}"
				#!$NEOTERM_PREFIX/bin/sh
				svlogger="$NEOTERM_PREFIX/share/neoterm-services/svlogger"
				exec "\${svlogger}" "\$@"
			EOF
			chmod 0700 "${_log_run}"

			NEOTERM_PKG_CONFFILES+="
			var/service/${NEOTERM_PKG_SERVICE_SCRIPT[$i]}/log/run
			var/service/${NEOTERM_PKG_SERVICE_SCRIPT[$i]}/log/down
			"
		fi
	done
}
