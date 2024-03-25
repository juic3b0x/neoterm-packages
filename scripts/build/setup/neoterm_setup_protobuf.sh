neoterm_setup_protobuf() {
	local _PROTOBUF_VERSION=$(bash -c ". $NEOTERM_SCRIPTDIR/packages/libprotobuf/build.sh; echo \${NEOTERM_PKG_VERSION#*:}")
	local _PROTOBUF_ZIP=protoc-$_PROTOBUF_VERSION-linux-x86_64.zip
	local _PROTOBUF_FOLDER

	if [ "${NEOTERM_PACKAGES_OFFLINE-false}" = "true" ]; then
		_PROTOBUF_FOLDER=${NEOTERM_SCRIPTDIR}/build-tools/protobuf-${_PROTOBUF_VERSION}
	else
		_PROTOBUF_FOLDER=${NEOTERM_COMMON_CACHEDIR}/protobuf-${_PROTOBUF_VERSION}
	fi

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		if [ ! -d "$_PROTOBUF_FOLDER" ]; then
			neoterm_download \
				https://github.com/protocolbuffers/protobuf/releases/download/v$_PROTOBUF_VERSION/$_PROTOBUF_ZIP \
				$NEOTERM_PKG_TMPDIR/$_PROTOBUF_ZIP \
				ed8fca87a11c888fed329d6a59c34c7d436165f662a2c875246ddb1ac2b6dd50

			rm -Rf "$NEOTERM_PKG_TMPDIR/protoc-$_PROTOBUF_VERSION-linux-x86_64"
			unzip $NEOTERM_PKG_TMPDIR/$_PROTOBUF_ZIP -d $NEOTERM_PKG_TMPDIR/protobuf-$_PROTOBUF_VERSION
			mv "$NEOTERM_PKG_TMPDIR/protobuf-$_PROTOBUF_VERSION" \
				$_PROTOBUF_FOLDER
		fi

		export PATH=$_PROTOBUF_FOLDER/bin/:$PATH
	fi
}
