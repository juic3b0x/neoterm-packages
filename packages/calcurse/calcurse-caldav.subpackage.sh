NEOTERM_SUBPKG_INCLUDE="bin/calcurse-caldav"
NEOTERM_SUBPKG_DESCRIPTION="Sync calcurse with remote caldav calendar"
NEOTERM_SUBPKG_DEPENDS="python, python-pip"
NEOTERM_SUBPKG_REPLACES="calcurse (<< 4.7.1-1)"
NEOTERM_SUBPKG_BREAKS="calcurse (<< 4.7.1-1)"

neoterm_step_create_subpkg_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "pip3 install httplib2" >> postinst
}
