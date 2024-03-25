NEOTERM_SUBPKG_DESCRIPTION="Tkinter support for PyPy 3"
NEOTERM_SUBPKG_DEPENDS="tk"
NEOTERM_SUBPKG_INCLUDE="
opt/pypy3/lib/pypy$_MAJOR_VERSION/_tkinter/*
"

neoterm_step_create_subpkg_debscripts() {
	# Pre-rm script to cleanup runtime-generated files.
	cat <<- PRERM_EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh

	if [ "$NEOTERM_PACKAGE_FORMAT" != "pacman" ] && [ "\$1" != "remove" ]; then
	    exit 0
	fi

	echo "Deleting *.pyc..."
	find $NEOTERM_PREFIX/opt/pypy3/lib/pypy$_MAJOR_VERSION/_tkinter/ | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

	exit 0
	PRERM_EOF

	chmod 0755 prerm
}
