NEOTERM_PKG_HOMEPAGE=http://site.icu-project.org/home
NEOTERM_PKG_DESCRIPTION='International Components for Unicode library'
NEOTERM_PKG_LICENSE="custom"
# We override NEOTERM_PKG_SRCDIR neoterm_step_post_get_source so need to do
# this hack to be able to find the license file.
NEOTERM_PKG_LICENSE_FILE="../LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Never forget to always bump revision of reverse dependencies and rebuild them
# when bumping "major" version.
NEOTERM_PKG_VERSION="74.2"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/unicode-org/icu/releases/download/release-${NEOTERM_PKG_VERSION//./-}/icu4c-${NEOTERM_PKG_VERSION//./_}-src.tgz
NEOTERM_PKG_SHA256=68db082212a96d6f53e35d60f47d38b962e9f9d207a74cfac78029ae8ff5e08c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BREAKS="libicu-dev"
NEOTERM_PKG_REPLACES="libicu-dev"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-samples --disable-tests"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-samples --disable-tests --with-cross-build=$NEOTERM_PKG_HOSTBUILD_DIR"

neoterm_step_post_get_source() {
	rm $NEOTERM_PKG_SRCDIR/LICENSE
	curl -o $NEOTERM_PKG_SRCDIR/LICENSE -L https://raw.githubusercontent.com/unicode-org/icu/release-${NEOTERM_PKG_VERSION//./-}/LICENSE
	NEOTERM_PKG_SRCDIR+="/source"
	find . -type f | xargs touch
}

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/libicuuc.so.74"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
