NEOTERM_PKG_HOMEPAGE=https://github.com/ajeetdsouza/zoxide
NEOTERM_PKG_DESCRIPTION="A faster way to navigate your filesystem"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.9.4"
NEOTERM_PKG_SRCURL=https://github.com/ajeetdsouza/zoxide/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=ec002bdca37917130ae34e733eb29d4baa03b130c4b11456d630a01a938e0187
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	rm -f ./Makefile
}

neoterm_step_post_make_install() {
	# Install man page:
	mkdir -p $NEOTERM_PREFIX/share/man/man1/
	cp -r $NEOTERM_PKG_SRCDIR/man/* $NEOTERM_PREFIX/share/man/man1/
}
