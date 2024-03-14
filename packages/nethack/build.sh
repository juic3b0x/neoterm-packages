NEOTERM_PKG_HOMEPAGE=http://www.nethack.org/
NEOTERM_PKG_DESCRIPTION="Dungeon crawl game"
NEOTERM_PKG_LICENSE="Nethack"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.6.7
NEOTERM_PKG_SRCURL=https://www.nethack.org/download/${NEOTERM_PKG_VERSION}/nethack-${NEOTERM_PKG_VERSION//./}-src.tgz
NEOTERM_PKG_SHA256=98cf67df6debf9668a61745aa84c09bcab362e5d33f5b944ec5155d44d2aacb2
NEOTERM_PKG_DEPENDS="gzip, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_GROUPS="games"

neoterm_step_host_build() {
	cp -r $NEOTERM_PKG_SRCDIR/* .
	pushd sys/unix
	sh setup.sh hints/linux
	popd && cd util
	if [ $NEOTERM_ARCH_BITS = 32 ]; then
		HOST_CC="gcc -m32"
	else
		HOST_CC="gcc"
	fi
	CFLAGS="" CC="$HOST_CC" LD="ld" make makedefs
	CFLAGS="" CC="$HOST_CC" LD="ld" make lev_comp
	CFLAGS="" CC="$HOST_CC" LD="ld" make dgn_comp dlb recover
}

neoterm_step_pre_configure() {
	WINTTYLIB="$LDFLAGS -lcurses"
	export LFLAGS="$LDFLAGS"
	export CFLAGS="$CPPFLAGS $CFLAGS"
	cd sys/unix
	sh setup.sh hints/linux
}

neoterm_step_post_configure() {
	# cp hostbuilt tools from hostbuild dir
	cp $NEOTERM_PKG_HOSTBUILD_DIR/util/{makedefs,lev_comp,dgn_comp,dlb} \
		util/
	touch -d "next hour" util/*
}

neoterm_step_post_make_install() {
	cd doc
	mkdir -p $NEOTERM_PREFIX/share/man/man6
	install -m600 nethack.6 $NEOTERM_PREFIX/share/man/man6/
	ln -sf $NEOTERM_PREFIX/games/nethack $NEOTERM_PREFIX/bin/
}

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "mkdir -p $NEOTERM_PREFIX/games/nethackdir/save" >> postinst
	echo "exit 0" >> postinst
}
