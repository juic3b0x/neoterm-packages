NEOTERM_PKG_HOMEPAGE=https://github.com/openSUSE/hwinfo
NEOTERM_PKG_DESCRIPTION="Hardware detection tool from openSUSE"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=22.3
NEOTERM_PKG_SRCURL=https://github.com/openSUSE/hwinfo/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=4ce5a852a9c58d70f59108382448097ffc4783ff336978ae49ec870ce02e99db
NEOTERM_PKG_DEPENDS="libandroid-shmem, libuuid, libx86emu"
NEOTERM_PKG_BREAKS="hwinfo-dev"
NEOTERM_PKG_REPLACES="hwinfo-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	sed -i -E '/^SUBDIRS\s*=/d' Makefile
	echo -e '\n$(LIBHD):\n\t$(MAKE) -C src' >> Makefile
	echo -e '\t$(CC) -shared $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) \' >> Makefile
	echo -e '\t\t-Wl,--whole-archive $(LIBHD) -Wl,--no-whole-archive \' >> Makefile
	echo -e '\t\t-Wl,-soname=$(LIBHD_SONAME) -o $(LIBHD_SO) $(SO_LIBS)' >> Makefile
}

neoterm_step_configure() {
	echo 'touch changelog' > git2log
	LDFLAGS+=" -landroid-shmem"
	export HWINFO_VERSION="$NEOTERM_PKG_VERSION"
	export DESTDIR="$NEOTERM_PREFIX"
}
