NEOTERM_SUBPKG_DESCRIPTION="Apache 2.0 Handler module for PHP"
NEOTERM_SUBPKG_DEPENDS="apache2, apr-util"
NEOTERM_SUBPKG_INCLUDE="libexec/apache2/libphp.so"

neoterm_step_create_subpkg_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo
	echo "    Extensions for PHP/Apache are packaged under the name of 'php-apache-*'"
	echo "    and are installed under the directory '\\\$PREFIX/lib/php-apache/'."
	echo
	echo "    (Extensions under '\\\$PREFIX/lib/php/' will not work with PHP/Apache.)"
	echo
	EOF
}
