NEOTERM_PKG_HOMEPAGE="https://p11-glue.github.io/p11-glue/p11-kit.html"
NEOTERM_PKG_DESCRIPTION="Provides a way to load and enumerate PKCS#11 modules"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@leapofazzam123"
NEOTERM_PKG_VERSION="0.25.3"
NEOTERM_PKG_SRCURL="https://github.com/p11-glue/p11-kit/releases/download/$NEOTERM_PKG_VERSION/p11-kit-$NEOTERM_PKG_VERSION.tar.xz"
NEOTERM_PKG_SHA256=d8ddce1bb7e898986f9d250ccae7c09ce14d82f1009046d202a0eb1b428b2adc
NEOTERM_PKG_DEPENDS="libffi, libtasn1"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--without-trust-paths --disable-static"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local a
	for a in CURRENT AGE; do
		local _LT_${a}=$(sed -En 's/^P11KIT_'"${a}"'=([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	autoreconf -fi
}
