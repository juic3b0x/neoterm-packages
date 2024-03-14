NEOTERM_PKG_HOMEPAGE=https://abiword.github.io/enchant/
NEOTERM_PKG_DESCRIPTION="Wraps a number of different spelling libraries and programs with a consistent interface"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.6.7"
NEOTERM_PKG_SRCURL=https://github.com/AbiWord/enchant/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b403842856f3824f0c123fc31bc59aa53a70da6501f8fb1daace9ee30931f944
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-relocatable" 
NEOTERM_PKG_DEPENDS="aspell, glib, hunspell, libc++"

neoterm_step_post_get_source() {
	./bootstrap
}

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libenchant-2.so"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done
}
