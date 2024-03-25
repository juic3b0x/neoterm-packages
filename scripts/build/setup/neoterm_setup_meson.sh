neoterm_setup_meson() {
	neoterm_setup_ninja
	local MESON_VERSION=1.2.2
	local MESON_FOLDER

	if [ "${NEOTERM_PACKAGES_OFFLINE-false}" = "true" ]; then
		MESON_FOLDER=${NEOTERM_SCRIPTDIR}/build-tools/meson-${MESON_VERSION}
	else
		MESON_FOLDER=${NEOTERM_COMMON_CACHEDIR}/meson-${MESON_VERSION}
	fi

	if [ ! -d "$MESON_FOLDER" ]; then
		local MESON_TAR_NAME=meson-$MESON_VERSION.tar.gz
		local MESON_TAR_FILE=$NEOTERM_PKG_TMPDIR/$MESON_TAR_NAME
		local MESON_TMP_FOLDER=$NEOTERM_PKG_TMPDIR/meson-$MESON_VERSION
		neoterm_download \
			"https://github.com/mesonbuild/meson/releases/download/$MESON_VERSION/meson-$MESON_VERSION.tar.gz" \
			"$MESON_TAR_FILE" \
			4a0f04de331fbc7af3b802a844fc8838f4ccd1ded1e792ba4f8f2faf8c5fe4d6
		tar xf "$MESON_TAR_FILE" -C "$NEOTERM_PKG_TMPDIR"
		shopt -s nullglob
		local f
		for f in "$NEOTERM_SCRIPTDIR"/scripts/build/setup/meson-*.patch; do
			echo "[${FUNCNAME[0]}]: Applying $(basename "$f")"
			patch --silent -p1 -d "$MESON_TMP_FOLDER" < "$f"
		done
		shopt -u nullglob
		mv "$MESON_TMP_FOLDER" "$MESON_FOLDER"
	fi
	NEOTERM_MESON="$MESON_FOLDER/meson.py"
	NEOTERM_MESON_CROSSFILE=$NEOTERM_PKG_TMPDIR/meson-crossfile-$NEOTERM_ARCH.txt
	local MESON_CPU MESON_CPU_FAMILY
	if [ "$NEOTERM_ARCH" = "arm" ]; then
		MESON_CPU_FAMILY="arm"
		MESON_CPU="armv7"
	elif [ "$NEOTERM_ARCH" = "i686" ]; then
		MESON_CPU_FAMILY="x86"
		MESON_CPU="i686"
	elif [ "$NEOTERM_ARCH" = "x86_64" ]; then
		MESON_CPU_FAMILY="x86_64"
		MESON_CPU="x86_64"
	elif [ "$NEOTERM_ARCH" = "aarch64" ]; then
		MESON_CPU_FAMILY="aarch64"
		MESON_CPU="aarch64"
	else
		neoterm_error_exit "Unsupported arch: $NEOTERM_ARCH"
	fi

	local CONTENT=""
	echo "[binaries]" > $NEOTERM_MESON_CROSSFILE
	echo "ar = '$AR'" >> $NEOTERM_MESON_CROSSFILE
	echo "c = '$CC'" >> $NEOTERM_MESON_CROSSFILE
	echo "cmake = 'cmake'" >> $NEOTERM_MESON_CROSSFILE
	echo "cpp = '$CXX'" >> $NEOTERM_MESON_CROSSFILE
	echo "ld = '$LD'" >> $NEOTERM_MESON_CROSSFILE
	echo "pkgconfig = '$PKG_CONFIG'" >> $NEOTERM_MESON_CROSSFILE
	echo "strip = '$STRIP'" >> $NEOTERM_MESON_CROSSFILE

	if [ "$NEOTERM_PACKAGE_LIBRARY" = "bionic" ]; then
		echo '' >> $NEOTERM_MESON_CROSSFILE
		echo "[properties]" >> $NEOTERM_MESON_CROSSFILE
		echo "needs_exe_wrapper = true" >> $NEOTERM_MESON_CROSSFILE
  	fi

	echo '' >> $NEOTERM_MESON_CROSSFILE
	echo "[built-in options]" >> $NEOTERM_MESON_CROSSFILE

	echo -n "c_args = [" >> $NEOTERM_MESON_CROSSFILE
	local word first=true
	for word in $CFLAGS $CPPFLAGS; do
		if [ "$first" = "true" ]; then
			first=false
		else
			echo -n ", " >> $NEOTERM_MESON_CROSSFILE
		fi
		echo -n "'$word'" >> $NEOTERM_MESON_CROSSFILE
	done
	echo ']' >> $NEOTERM_MESON_CROSSFILE

	echo -n "cpp_args = [" >> $NEOTERM_MESON_CROSSFILE
	local word first=true
	for word in $CXXFLAGS $CPPFLAGS; do
		if [ "$first" = "true" ]; then
			first=false
		else
			echo -n ", " >> $NEOTERM_MESON_CROSSFILE
		fi
		echo -n "'$word'" >> $NEOTERM_MESON_CROSSFILE
	done
	echo ']' >> $NEOTERM_MESON_CROSSFILE

	local property
	for property in c_link_args cpp_link_args; do
		echo -n "$property = [" >> $NEOTERM_MESON_CROSSFILE
		first=true
		for word in $LDFLAGS; do
			if [ "$first" = "true" ]; then
				first=false
			else
				echo -n ", " >> $NEOTERM_MESON_CROSSFILE
			fi
			echo -n "'$word'" >> $NEOTERM_MESON_CROSSFILE
		done
		echo ']' >> $NEOTERM_MESON_CROSSFILE
	done

	echo '' >> $NEOTERM_MESON_CROSSFILE
	echo "[host_machine]" >> $NEOTERM_MESON_CROSSFILE
	echo "cpu_family = '$MESON_CPU_FAMILY'" >> $NEOTERM_MESON_CROSSFILE
	echo "cpu = '$MESON_CPU'" >> $NEOTERM_MESON_CROSSFILE
	echo "endian = 'little'" >> $NEOTERM_MESON_CROSSFILE
 	if [ "$NEOTERM_PACKAGE_LIBRARY" = "bionic" ]; then
		echo "system = 'android'" >> $NEOTERM_MESON_CROSSFILE
  	elif [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
		echo "system = 'linux'" >> $NEOTERM_MESON_CROSSFILE
     	fi
}
