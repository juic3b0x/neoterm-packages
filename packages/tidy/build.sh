NEOTERM_PKG_HOMEPAGE=http://www.html-tidy.org/
NEOTERM_PKG_DESCRIPTION="A tool to tidy down your HTML code to a clean style"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="README/LICENSE.md"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Using unstable API version due to CVE-2021-33391.
# Please revbump revdeps to rebuild when bumping version.
NEOTERM_PKG_VERSION=5.9.14-next
NEOTERM_PKG_SRCURL=https://github.com/htacg/tidy-html5/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=83cc9d9cdfa59bfe400dc745dea14eb1e1be4ca088facfb911eac8b78e75f2b4
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libxslt"
NEOTERM_PKG_BREAKS="tidy-dev"
NEOTERM_PKG_REPLACES="tidy-dev"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=

	local _MAJOR=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1)
	local _MINOR=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 2)
	local v=
	if [ $(( _MINOR % 2 )) == 0 ]; then
		v="${_MAJOR}${_MINOR}"
	fi
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_host_build() {
	## Host build required to generate man pages.
	neoterm_setup_cmake
	cmake "$NEOTERM_PKG_SRCDIR" && make
}

neoterm_step_post_make_install() {
	install -Dm600 \
		"$NEOTERM_PKG_HOSTBUILD_DIR"/tidy.1 \
		"$NEOTERM_PREFIX"/share/man/man1/
}
