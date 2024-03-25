NEOTERM_PKG_HOMEPAGE=https://github.com/westes/flex
NEOTERM_PKG_DESCRIPTION="Fast lexical analyser generator"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.6.4
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/westes/flex/releases/download/v${NEOTERM_PKG_VERSION}/flex-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="m4"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="ac_cv_path_M4=$NEOTERM_PREFIX/bin/m4"
NEOTERM_PKG_CONFLICTS="flex-dev"
NEOTERM_PKG_REPLACES="flex-dev"
NEOTERM_PKG_GROUPS="base-devel"

# Work around https://github.com/westes/flex/issues/241 when building
# under ubuntu 17.10:
NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="CFLAGS=-D_GNU_SOURCE=1"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local e=$(sed -En 's/^SHARED_VERSION_INFO="?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			configure.ac)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	mkdir -p $NEOTERM_PKG_BUILDDIR/src/
	cp $NEOTERM_PKG_HOSTBUILD_DIR/src/stage1flex $NEOTERM_PKG_BUILDDIR/src/stage1flex
	touch -d "next hour" $NEOTERM_PKG_BUILDDIR/src/stage1flex
}
