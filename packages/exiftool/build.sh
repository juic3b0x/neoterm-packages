NEOTERM_PKG_HOMEPAGE=https://exiftool.org/
NEOTERM_PKG_DESCRIPTION="Utility for reading, writing and editing meta information in a wide variety of files."
NEOTERM_PKG_LICENSE="Artistic-License-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="12.78"
NEOTERM_PKG_SRCURL="https://exiftool.org/Image-ExifTool-$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=a2ef24cdd954ecfbc03d48c8e672601dc69843297c05e4742dc9ea7866ed281d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP='^\d+\.\d+(\.(?!0$)\d+)?'
NEOTERM_PKG_DEPENDS="perl"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	local current_perl_version=$(. $NEOTERM_SCRIPTDIR/packages/perl/build.sh; echo $NEOTERM_PKG_VERSION)

	install -Dm700 "$NEOTERM_PKG_SRCDIR"/exiftool "$NEOTERM_PREFIX"/bin/exiftool
	find "$NEOTERM_PKG_SRCDIR"/lib -name "*.pod" -delete
	mkdir -p "$NEOTERM_PREFIX/lib/perl5/site_perl/$current_perl_version"
	rm -rf "$NEOTERM_PREFIX/lib/perl5/site_perl/${current_perl_version}"/{Image,File}
	cp -a "$NEOTERM_PKG_SRCDIR"/lib/{Image,File} "$NEOTERM_PREFIX/lib/perl5/site_perl/${current_perl_version}/"
}
