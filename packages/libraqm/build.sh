NEOTERM_PKG_HOMEPAGE=https://github.com/HOST-Oman/libraqm
NEOTERM_PKG_DESCRIPTION="Raqm is a small library that encapsulates the logic for complex text layout and provides a convenient API"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.10.1"
NEOTERM_PKG_SRCURL=https://github.com/HOST-Oman/libraqm/releases/download/v$NEOTERM_PKG_VERSION/raqm-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=4d76a358358d67c5945684f2f10b3b08fb80e924371bf3ebf8b15cd2e321d05d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="freetype, harfbuzz, fribidi"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
