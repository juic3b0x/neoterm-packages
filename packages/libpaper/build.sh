NEOTERM_PKG_HOMEPAGE=https://github.com/rrthomas/psutils
NEOTERM_PKG_DESCRIPTION="Library for handling paper characteristics (by @rrthomas)"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.2.5"
NEOTERM_PKG_SRCURL="https://github.com/rrthomas/libpaper/releases/download/v${NEOTERM_PKG_VERSION}/libpaper-${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=7be50974ce0df0c74e7587f10b04272cd53fd675cb6a1273ae1cc5c9cc9cab09
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=${NEOTERM_PREFIX}/etc
--enable-relocatable
"
NEOTERM_PKG_PROVIDES="paper"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local v=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi

}

neoterm_step_pre_configure() {
	# 210x297 (in mm) is A4 size. Use as default to be provided by locale.
	CFLAGS+=" -D_NL_PAPER_WIDTH=210 -D_NL_PAPER_HEIGHT=297"
}

neoterm_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		mkdir -p ${NEOTERM_PREFIX}/etc/paper.d
	EOF
}
