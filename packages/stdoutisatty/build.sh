NEOTERM_PKG_HOMEPAGE=https://github.com/lilydjwg/stdoutisatty
NEOTERM_PKG_DESCRIPTION="Patch the isatty() calls for colored output in pipeline"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@flosnvjx"
NEOTERM_PKG_VERSION=1.0
NEOTERM_PKG_SRCURL=https://github.com/lilydjwg/stdoutisatty/archive/refs/tags/"$NEOTERM_PKG_VERSION".tar.gz
NEOTERM_PKG_SHA256=fadc12401cd89e718d7b0127b882cf47335f436ffcc7b83a9fbf557befe5beb2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_post_make_install() {
	cd "$NEOTERM_PKG_SRCDIR"
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME README.*
}
