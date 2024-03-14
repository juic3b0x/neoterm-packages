NEOTERM_PKG_HOMEPAGE=https://www.pcre.org
NEOTERM_PKG_DESCRIPTION="Perl 5 compatible regular expression library"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="10.43"
NEOTERM_PKG_SRCURL=https://github.com/PhilipHazel/pcre2/releases/download/pcre2-${NEOTERM_PKG_VERSION}/pcre2-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=e2a53984ff0b07dfdb5ae4486bbb9b21cca8e7df2434096cc9bf1b728c350bcb
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+"
NEOTERM_PKG_BREAKS="pcre2-dev"
NEOTERM_PKG_REPLACES="pcre2-dev"
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/pcre2test
share/man/man1/pcre2test.1
"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-jit
--enable-pcre2-16
--enable-pcre2-32
"
neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVER_libpcre2_8=0
	local _SOVER_libpcre2_16=0
	local _SOVER_libpcre2_32=0
	local _SOVER_libpcre2_posix=3

	local a
	for a in libpcre2_{8,16,32,posix}; do
		local e=$(sed -En 's/^m4_define\('"${a}"'_version,\s*\[([0-9]+):([0-9]+):([0-9]+)\].*/\1-\3/p' \
				configure.ac)
		if [ ! "${e}" ] || [ "$(eval echo \$_SOVER_${a})" != "$(( "${e}" ))" ]; then
			neoterm_error_exit "SOVERSION guard check failed for ${a/_/-}.so."
		fi
	done
}
