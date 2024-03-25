NEOTERM_PKG_HOMEPAGE=https://github.com/anordal/shellharden
NEOTERM_PKG_DESCRIPTION="The corrective bash syntax highlighter"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.3.0
NEOTERM_PKG_SRCURL=https://github.com/anordal/shellharden/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=d17bf55bae4ed6aed9f0d5cea8efd11026623a47b6d840b826513ab5b48db3eb
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_post_make_install() {
	install -Dm700 \
		"$NEOTERM_PKG_SRCDIR/target/$CARGO_TARGET_NAME"/release/shellharden \
		"$NEOTERM_PREFIX"/bin/
}
