NEOTERM_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/pkg-config/
NEOTERM_PKG_DESCRIPTION="Helper tool used when compiling applications and libraries"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.29.2
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://pkgconfig.freedesktop.org/releases/pkg-config-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6fc69c01688c9458a57eb9a1664c9aba372ccda420a02bf4429fe610e7e7d591
NEOTERM_PKG_DEPENDS="glib"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/*-pkg-config"
NEOTERM_PKG_GROUPS="base-devel"

neoterm_step_pre_configure() {
	# Use ln -s instead of ln to avoid attempt at hardlinking on
	# device
	export ac_cv_prog_LN='ln -s'
}
