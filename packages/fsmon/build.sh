NEOTERM_PKG_HOMEPAGE=https://github.com/nowsecure/fsmon
NEOTERM_PKG_DESCRIPTION="Filesystem monitor with fanotify and inotify backends"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.8.5
NEOTERM_PKG_SRCURL=https://github.com/nowsecure/fsmon/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=eb99cfb242bea9fc5bde66e67f4324bd71100d17b1672e4e52db14b9a5e2900a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	make FANOTIFY_CFLAGS="-DHAVE_FANOTIFY=1 -DHAVE_SYS_FANOTIFY=0"
}
