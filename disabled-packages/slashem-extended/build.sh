NEOTERM_PKG_HOMEPAGE=https://nethackwiki.com/wiki/Slash%27EM_Extended
NEOTERM_PKG_DESCRIPTION="A variant of SLASH'EM (a variant of NetHack)"
NEOTERM_PKG_LICENSE="Nethack"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.7.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/SLASHEM-Extended/SLASHEM-Extended/archive/refs/tags/slex-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=54d301bcb8d79d92030a30195f091e694f843d4656061dbce85730fc12023dee
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	for s in dgn lev; do
		ln -sf ${s}_comp.h include/${s}.tab.h
	done
	for f in alloc.c decl.c dlb.c drawing.c monst.c objects.c; do
		ln -sf ../src/$f util/$f
	done
}

neoterm_step_make() {
	CFLAGS+=" -fcommon -DMAILPATH=\\\"/dev/null\\\""
	export CFLAGS_FOR_BUILD="-m${NEOTERM_ARCH_BITS} -O2 -fcommon"
	export LDFLAGS_FOR_BUILD="-m${NEOTERM_ARCH_BITS}"
	make -f sys/unix/GNUmakefile
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin "$NEOTERM_PKG_BUILDDIR/src/slex"
	install -Dm600 -t $NEOTERM_PREFIX/share/games/slex "$NEOTERM_PKG_BUILDDIR/dat/nhdat"
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/slex "$NEOTERM_PKG_SRCDIR/dat/license"
}

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "mkdir -p $NEOTERM_PREFIX/var/games/slex" >> postinst
	echo "touch $NEOTERM_PREFIX/var/games/slex/perm" >> postinst
	echo "touch $NEOTERM_PREFIX/var/games/slex/record" >> postinst
	echo "mkdir -p $NEOTERM_PREFIX/var/games/slex/save" >> postinst
	echo "mkdir -p $NEOTERM_PREFIX/var/games/slex/unshare" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
