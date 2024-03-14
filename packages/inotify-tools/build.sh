NEOTERM_PKG_HOMEPAGE=https://github.com/rvoicilas/inotify-tools/wiki
NEOTERM_PKG_DESCRIPTION="Programs providing a simple interface to inotify"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.23.9.0"
NEOTERM_PKG_SRCURL=https://github.com/rvoicilas/inotify-tools/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1dfa33f80b6797ce2f6c01f454fd486d30be4dca1b0c5c2ea9ba3c30a5c39855
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="inotify-tools-dev"
NEOTERM_PKG_REPLACES="inotify-tools-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	./autogen.sh
}

neoterm_step_make() {
	:
}

neoterm_step_make_install() {
	# the command-line tools needs the libinotifytools installed before building
	make -C libinotifytools install
	make install
}
