NEOTERM_PKG_HOMEPAGE=https://calcurse.org/
NEOTERM_PKG_DESCRIPTION="calcurse is a calendar and scheduling application for the command line"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.8.1
NEOTERM_PKG_SRCURL=https://calcurse.org/files/calcurse-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=d86bb37014fd69b8d83ccb904ac979c6b8ddf59ee3dbc80f5a274525e4d5830a
NEOTERM_PKG_DEPENDS="libandroid-support, ncurses"
NEOTERM_PKG_RECOMMENDS="calcurse-caldav"

neoterm_step_pre_configure() {
	export ac_cv_lib_pthread_pthread_create=yes
}
