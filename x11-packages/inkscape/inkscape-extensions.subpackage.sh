NEOTERM_SUBPKG_INCLUDE="share/inkscape/extensions"
NEOTERM_SUBPKG_DESCRIPTION="Inkscape extensions"
NEOTERM_SUBPKG_DEPENDS="python, python-numpy, python-pip, python-lxml"
NEOTERM_SUBPKG_PLATFORM_INDEPENDENT=true

neoterm_step_create_subpkg_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install scour
	EOF
}
