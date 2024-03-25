NEOTERM_PKG_HOMEPAGE=https://ps-auxw.de/avs2bdnxml/
NEOTERM_PKG_DESCRIPTION="AVS to BluRay SUP/PGS and BDN XML"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=42a5572c631bbb4dcf9b43d07179de8c5607d47c
NEOTERM_PKG_VERSION=2019.02.06
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/hguandl/ass2bdnxml
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="libpng"

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$NEOTERM_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$NEOTERM_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}

neoterm_step_pre_configure() {
	LDFLAGS+=" -lm"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin ass2bdnxml
}
