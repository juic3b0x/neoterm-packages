NEOTERM_PKG_HOMEPAGE=https://taskwarrior.org
NEOTERM_PKG_DESCRIPTION="Utility for managing your TODO list"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.6.2
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/GothenburgBitFactory/taskwarrior/releases/download/v${NEOTERM_PKG_VERSION}/task-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b1d3a7f000cd0fd60640670064e0e001613c9e1cb2242b9b3a9066c78862cfec
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libgnutls, libuuid, libandroid-glob"
NEOTERM_CMAKE_BUILD="Unix Makefiles"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

neoterm_step_post_make_install() {
	install -Dm600 -T "$NEOTERM_PKG_SRCDIR"/scripts/bash/task.sh \
		$NEOTERM_PREFIX/share/bash-completion/completions/task
	install -Dm600 -t $NEOTERM_PREFIX/share/fish/vendor_completions.d \
		"$NEOTERM_PKG_SRCDIR"/scripts/fish/task.fish
}
