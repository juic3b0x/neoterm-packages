NEOTERM_PKG_HOMEPAGE=https://github.com/couchbase/forestdb
NEOTERM_PKG_DESCRIPTION="A key-value storage engine"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2
NEOTERM_PKG_SRCURL=https://github.com/couchbase/forestdb/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=52463e4e3bd94ff70503b8a278ec0304c13acb6862e5d5fd3d2b3f05e60b7aa0
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libsnappy"

neoterm_step_post_configure() {
	if [ "$NEOTERM_CMAKE_BUILD" == "Ninja" ]; then
		sed -i -e 's:\$INCLUDES:& -I'$NEOTERM_PREFIX'/include:g' \
			CMakeFiles/rules.ninja
	fi
}
