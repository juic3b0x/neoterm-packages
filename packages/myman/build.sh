NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/myman/
NEOTERM_PKG_DESCRIPTION="Video game for color and monochrome text terminals in the genre of Namco's Pac-Man"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION=0.7.1
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_SRCURL=https://sourceforge.net/projects/myman/files/myman-cvs/myman-cvs-2009-10-30/myman-cvs-2009-10-30.tar.gz
NEOTERM_PKG_SHA256=253e22f26dc95c63388bc4cb81075a05f77f7709d1d64ed9fde7aae38a7fc962
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_HOSTBUILD=true
# myman is installed twice for no reason
NEOTERM_PKG_RM_AFTER_INSTALL="bin/myman-$NEOTERM_PKG_VERSION"
NEOTERM_PKG_GROUPS="games"

neoterm_step_get_source() {
	cd $NEOTERM_PKG_CACHEDIR
	neoterm_download "${NEOTERM_PKG_SRCURL}" "$(basename ${NEOTERM_PKG_SRCURL})" "${NEOTERM_PKG_SHA256}"
	tar -xf "$(basename ${NEOTERM_PKG_SRCURL})"
	mkdir -p $NEOTERM_PKG_SRCDIR
	cd $NEOTERM_PKG_SRCDIR
	cvs -d$NEOTERM_PKG_CACHEDIR/myman-cvs co -P myman
	mv myman/* .
}

neoterm_step_host_build() {
	$NEOTERM_PKG_SRCDIR/configure
	make obj/s1game
}

neoterm_step_post_configure() {
	mkdir -p obj
	cp $NEOTERM_PKG_HOSTBUILD_DIR/obj/s1game obj/
	touch -d "next hour" obj/s1game
}
