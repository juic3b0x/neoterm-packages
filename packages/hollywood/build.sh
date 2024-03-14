NEOTERM_PKG_HOMEPAGE=https://launchpad.net/hollywood
NEOTERM_PKG_DESCRIPTION="Fill your console with Hollywood melodrama technobabble"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.22"
COMMIT="35275a68c37bbc39d8b2b0e4664a0c2f5451e5f6"
NEOTERM_PKG_SRCURL=https://github.com/dustinkirkland/hollywood/archive/${COMMIT}.tar.gz
NEOTERM_PKG_SHA256=7eab1994b4320ee8b3de751465082aed1f5fd12a8d8082ef749ed1249ea0b583
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="bmon, byobu, cmatrix, coreutils, dash, gawk, htop, man, tree, util-linux"
NEOTERM_PKG_RECOMMENDS="apg"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	install -dm0700 "$NEOTERM_PREFIX"/{bin,lib/hollywood,share/{man/man1,hollywood}}
	install -m 0700 "$NEOTERM_PKG_SRCDIR"/bin/hollywood  "$NEOTERM_PREFIX"/bin/
	install -m 0700 "$NEOTERM_PKG_SRCDIR"/lib/hollywood/* "$NEOTERM_PREFIX"/lib/hollywood/
	install -m 0600 "$NEOTERM_PKG_SRCDIR"/share/hollywood/*  "$NEOTERM_PREFIX"/share/hollywood/
	install -m 0600 "$NEOTERM_PKG_SRCDIR"/share/man/man1/*  "$NEOTERM_PREFIX"/share/man/man1/
}
