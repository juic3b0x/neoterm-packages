NEOTERM_PKG_HOMEPAGE=https://launchpad.net/intltool
NEOTERM_PKG_DESCRIPTION="The internationalization tool collection"
NEOTERM_PKG_MAINTAINER="@suhan-paradkar"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_VERSION=0.51.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://launchpad.net/intltool/trunk/$NEOTERM_PKG_VERSION/+download/intltool-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=67c74d94196b153b774ab9f89b2fa6c6ba79352407037c8c14d5aeb334e959cd
NEOTERM_PKG_DEPENDS="perl, clang, make, libexpat"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_create_debscripts()  {
	cat <<- POSTINST_EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/bash
	set -e

	echo "Sideloading Perl XML::Parser..."
	cpan install XML::Parser

	exit 0
	POSTINST_EOF
}
