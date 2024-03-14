NEOTERM_PKG_HOMEPAGE=https://packages.debian.org/sid/texinfo
NEOTERM_PKG_DESCRIPTION="Update or create index file from all installed info files in directory"
NEOTERM_PKG_LICENSE="GPL-2.0, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=6.8-6
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/t/texinfo/texinfo_${NEOTERM_PKG_VERSION}.debian.tar.xz
NEOTERM_PKG_SHA256=1399525b5c61cdd10a525370975f11d8dc61e9ea54616beed212fe8e98846894
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin update-info-dir
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man8 update-info-dir.8
}

neoterm_step_create_debscripts() {
	local INFODIR=$NEOTERM_PREFIX/share/info

	cat <<- EOF > ./triggers
	interest-noawait $INFODIR
	EOF

	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ -d $INFODIR ]; then
	    $NEOTERM_PREFIX/bin/update-info-dir
	fi
	exit 0
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	rm -rf $INFODIR/dir
	exit 0
	EOF
}
