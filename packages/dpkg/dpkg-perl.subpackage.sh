NEOTERM_SUBPKG_DESCRIPTION="Perl modules for dpkg"
NEOTERM_SUBPKG_INCLUDE="share/perl5"
NEOTERM_SUBPKG_DEPENDS="perl, clang, make"
NEOTERM_SUBPKG_PLATFORM_INDEPENDENT=true

neoterm_step_create_subpkg_debscripts() {
	cat <<- POSTINST_EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/bash
	set -e

	echo "Sideloading Perl Locale::gettext ..."
	cpan -fi Locale::gettext

	exit 0
	POSTINST_EOF
}
