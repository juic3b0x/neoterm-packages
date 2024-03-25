NEOTERM_PKG_HOMEPAGE=https://rig.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A program that generates fake identities"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.11
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/rig/rig/rig-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=00bfc970d5c038c1e68bc356c6aa6f9a12995914b7d4fda69897622cb5b77ab8
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin rig
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man6 rig.6
	install -Dm600 -t $NEOTERM_PREFIX/share/rig data/*.idx
}
