neoterm_setup_python_pip() {
	if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ]; then
		if [[ "$NEOTERM_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' python-pip 2>/dev/null)" != "installed" ]] ||
		[[ "$NEOTERM_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q python-pip 2>/dev/null)" ]]; then
			echo "Package 'python-pip' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install python-pip"
			echo
			echo "  pacman -S python-pip"
			echo
			echo "Note that package 'python-pip' is known to be problematic for building on device."
			exit 1
		fi

		# Setup a virtual environment and do not mess the system site-packages
		local _VENV_DIR="${NEOTERM_PKG_TMPDIR}/venv-dir"

		mkdir -p "$_VENV_DIR"
		python${NEOTERM_PYTHON_VERSION} -m venv --system-site-packages "$_VENV_DIR"
		. "$_VENV_DIR/bin/activate"
		return
	else
		local _CROSSENV_VERSION=1.4.0
		local _CROSSENV_TAR=crossenv-$_CROSSENV_VERSION.tar.gz
		local _CROSSENV_FOLDER

		if [ "${NEOTERM_PACKAGES_OFFLINE-false}" = "true" ]; then
			_CROSSENV_FOLDER=${NEOTERM_SCRIPTDIR}/build-tools/crossenv-${_CROSSENV_VERSION}
		else
			_CROSSENV_FOLDER=${NEOTERM_COMMON_CACHEDIR}/crossenv-${_CROSSENV_VERSION}
		fi
		export NEOTERM_PYTHON_CROSSENV_SRCDIR=$_CROSSENV_FOLDER

		if [ ! -d "$_CROSSENV_FOLDER" ]; then
			neoterm_download \
				https://github.com/benfogle/crossenv/archive/refs/tags/v$_CROSSENV_VERSION.tar.gz \
				$NEOTERM_PKG_TMPDIR/$_CROSSENV_TAR \
				28da6260fafd85b05fa539793c45ef804c700a0bb71172fadef429796d49ac4e

			rm -Rf "$NEOTERM_PKG_TMPDIR/crossenv-$_CROSSENV_VERSION"
			tar xf $NEOTERM_PKG_TMPDIR/$_CROSSENV_TAR -C $NEOTERM_PKG_TMPDIR
			mv "$NEOTERM_PKG_TMPDIR/crossenv-$_CROSSENV_VERSION" \
				$_CROSSENV_FOLDER
			shopt -s nullglob
			local f
			for f in "$NEOTERM_SCRIPTDIR"/scripts/build/setup/python-crossenv-*.patch; do
				echo "[${FUNCNAME[0]}]: Applying $(basename "$f")"
				patch --silent -p1 -d "$_CROSSENV_FOLDER" < "$f"
			done
			shopt -u nullglob
		fi

		if [ ! -d "$NEOTERM_PYTHON_CROSSENV_PREFIX" ]; then
			cd "$NEOTERM_PYTHON_CROSSENV_SRCDIR"
			python${NEOTERM_PYTHON_VERSION} -m crossenv \
                		"$NEOTERM_PREFIX/bin/python${NEOTERM_PYTHON_VERSION}" \
				"${NEOTERM_PYTHON_CROSSENV_PREFIX}"
		fi
		. "${NEOTERM_PYTHON_CROSSENV_PREFIX}/bin/activate"

		export PATH="${PATH}:${NEOTERM_PYTHON_CROSSENV_PREFIX}/build/bin"
	fi
}
