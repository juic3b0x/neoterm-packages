NEOTERM_PKG_HOMEPAGE=https://github.com/spook/sshping
NEOTERM_PKG_DESCRIPTION="measure character-echo latency and bandwidth for an interactive ssh session"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1.4
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/spook/sshping/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=589623e3fbe88dc1d423829e821f9d57f09aef0d9a2f04b7740b50909217863a
NEOTERM_PKG_DEPENDS="libc++, libssh"
NEOTERM_PKG_EXTRA_MAKE_ARGS="sshping man"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	rm -f CMakeLists.txt
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin ./bin/sshping
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man8 ./doc/sshping.8
}
