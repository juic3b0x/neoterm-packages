NEOTERM_PKG_HOMEPAGE=https://www.rsnapshot.org/
NEOTERM_PKG_DESCRIPTION="A remote filesystem snapshot utility"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.4.5"
NEOTERM_PKG_SRCURL=https://github.com/rsnapshot/rsnapshot/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=8ef500e2eaee85a37fb8000f73b3b1325569fcfe940a7e8ea66a8f243cb289a3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="coreutils, openssh, perl, rsync"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-perl=$NEOTERM_PREFIX/bin/perl
--with-rsync=$NEOTERM_PREFIX/bin/rsync
--with-rm=$NEOTERM_PREFIX/bin/rm
--with-ssh=$NEOTERM_PREFIX/bin/ssh
--with-du=$NEOTERM_PREFIX/bin/du
"

NEOTERM_PKG_CONFFILES="etc/rsnapshot.conf"

neoterm_step_pre_configure() {
	./autogen.sh
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/etc
	sed -e "s%\@NEOTERM_BASE_DIR\@%${NEOTERM_BASE_DIR}%g" \
		-e "s%\@NEOTERM_CACHE_DIR\@%${NEOTERM_CACHE_DIR}%g" \
		-e "s%\@NEOTERM_HOME\@%${NEOTERM_ANDROID_HOME}%g" \
		-e "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" \
		$NEOTERM_PKG_BUILDER_DIR/rsnapshot.conf > $NEOTERM_PREFIX/etc/rsnapshot.conf
}
