NEOTERM_SUBPKG_DESCRIPTION="units_cur Python script"
NEOTERM_SUBPKG_INCLUDE="
bin/units_cur
"
NEOTERM_SUBPKG_PLATFORM_INDEPENDENT=true
NEOTERM_SUBPKG_DEPENDS="python, python-pip"
NEOTERM_SUBPKG_BREAKS="units (<< 2.22)"
NEOTERM_SUBPKG_REPLACES="units (<< 2.22)"

neoterm_step_create_subpkg_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install requests
	EOF
}
