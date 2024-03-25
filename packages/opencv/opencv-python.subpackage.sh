NEOTERM_SUBPKG_INCLUDE="lib/python*"
NEOTERM_SUBPKG_DESCRIPTION="Python bindings for OpenCV"
NEOTERM_SUBPKG_DEPENDS="python, python-numpy"

neoterm_step_create_subpkg_debscripts() {
	_NUMPY_VERSION=$(. $NEOTERM_SCRIPTDIR/packages/python-numpy/build.sh; echo $NEOTERM_PKG_VERSION)

	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	INSTALLED_NUMPY_VERSION=\$(dpkg --list python-numpy | grep python-numpy | awk '{print \$3; exit;}')
	if [ "\${INSTALLED_NUMPY_VERSION%%-*}" != "$_NUMPY_VERSION" ]; then
		echo "WARNING: opencv-python is compiled with numpy $_NUMPY_VERSION, but numpy \${INSTALLED_NUMPY_VERSION%%-*} is installed. Please report it to https://github.com/juic3b0x/neoterm-packages if any bug happens."
	fi
	EOF
}
