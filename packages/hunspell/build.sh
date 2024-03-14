NEOTERM_PKG_HOMEPAGE=https://hunspell.github.io
NEOTERM_PKG_DESCRIPTION="Spell checker"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.7.2"
NEOTERM_PKG_SRCURL=https://github.com/hunspell/hunspell/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=69fa312d3586c988789266eaf7ffc9861d9f6396c31fc930a014d551b59bbd6e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libiconv, ncurses, readline, hunspell-en-us"
NEOTERM_PKG_BREAKS="hunspell-dev"
NEOTERM_PKG_REPLACES="hunspell-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-ui --with-readline"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	autoreconf -vfi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libhunspell-1.7.so"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done
}
