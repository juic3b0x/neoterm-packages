NEOTERM_PKG_HOMEPAGE=https://taskwarrior.org
NEOTERM_PKG_DESCRIPTION="Shell command wrapping Taskwarrior commands"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.0
NEOTERM_PKG_REVISION=8
NEOTERM_PKG_SRCURL=https://taskwarrior.org/download/tasksh-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6e42f949bfd7fbdde4870af0e7b923114cc96c4344f82d9d924e984629e21ffd
NEOTERM_PKG_DEPENDS="libc++, readline, taskwarrior, libandroid-glob"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

