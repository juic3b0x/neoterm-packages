NEOTERM_PKG_HOMEPAGE=https://dirb.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Web Directory Fuzzer"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.22
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://sourceforge.net/projects/dirb/files/dirb/${NEOTERM_PKG_VERSION}/dirb${NEOTERM_PKG_VERSION/./}.tar.gz
NEOTERM_PKG_SHA256=f3748ade231ca211a01acbec31cc6a3b576f6c56c906d73329d7dbb79f60fc2c
NEOTERM_PKG_DEPENDS="libcurl"

neoterm_step_post_get_source() {
	# dirb222.tar.gz has directory permission problem
	chmod +x -R "$NEOTERM_PKG_SRCDIR"
}

neoterm_step_post_make_install() {
	mkdir -p "$NEOTERM_PREFIX"/share/dirb
	cp -rf  "$NEOTERM_PKG_SRCDIR"/wordlists "$NEOTERM_PREFIX"/share/dirb/wordlists
	find "$NEOTERM_PREFIX"/share/dirb/wordlists -type f | xargs chmod 600
	mv -f "$NEOTERM_PREFIX"/bin/gendict "$NEOTERM_PREFIX"/bin/dirb-gendict
}
