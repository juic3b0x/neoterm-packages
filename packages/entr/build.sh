NEOTERM_PKG_HOMEPAGE=http://eradman.com/entrproject/
NEOTERM_PKG_DESCRIPTION="Event Notify Test Runner - run arbitrary commands when files change"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.5"
NEOTERM_PKG_SRCURL=https://eradman.com/entrproject/code/entr-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=128c0ce2efea5ae6bd3fd33c3cd31e161eb0c02609d8717ad37e95b41656e526
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	./configure
}
