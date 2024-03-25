NEOTERM_PKG_HOMEPAGE="http://nongnu.org/jcal"
NEOTERM_PKG_DESCRIPTION="UNIX-cal-like tool to display Jalali (Persian/Iranian) calendar"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.4.1
NEOTERM_PKG_SRCURL="https://github.com/persiancal/jcal/archive/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=b55edc605eda0a5b25b8009391dcaeb3c8ba88d1fb3337a071f555983a114c12
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	cd sources
	./autogen.sh
	sed --in-place 's/$RM "$cfgfile"/$RM -f "$cfgfile"/g' configure
	NEOTERM_PKG_SRCDIR+="/sources"
}

neoterm_step_post_configure() {
	# removing tests
	sed --in-place 's/test_kit//g' sources/Makefile.am
}
