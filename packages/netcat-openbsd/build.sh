NEOTERM_PKG_HOMEPAGE=https://packages.debian.org/sid/netcat-openbsd
NEOTERM_PKG_DESCRIPTION="TCP/IP swiss army knife. OpenBSD variant."
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.226-1"
NEOTERM_PKG_SRCURL=https://salsa.debian.org/debian/netcat-openbsd/-/archive/debian/${NEOTERM_PKG_VERSION}/netcat-openbsd-debian-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=cd1c102e5954436184c3f7f3e7b649eed05ef38aa9592b55577ca28878b268d2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP="s/_/-/"
NEOTERM_PKG_DEPENDS="libbsd"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	local p
	for p in $(cat debian/patches/series); do
		echo "Applying debian/patches/$p"
		patch -p1 -i debian/patches/$p
	done

	sed -i -e 's@-lresolv@@g' \
		-e 's@CFLAGS=@CFLAGS?=@g' \
		Makefile

	CFLAGS+=" $CPPFLAGS $LDFLAGS"
}

neoterm_step_make_install() {
	install -Dm700 nc $NEOTERM_PREFIX/bin/netcat-openbsd
	ln -sfr $NEOTERM_PREFIX/bin/netcat-openbsd $NEOTERM_PREFIX/bin/netcat
	ln -sfr $NEOTERM_PREFIX/bin/netcat-openbsd $NEOTERM_PREFIX/bin/nc
	install -Dm600 nc.1 $NEOTERM_PREFIX/share/man/man1/netcat-openbsd.1
	ln -sfr $NEOTERM_PREFIX/share/man/man1/netcat-openbsd.1 \
		$NEOTERM_PREFIX/share/man/man1/netcat.1
	ln -sfr $NEOTERM_PREFIX/share/man/man1/netcat-openbsd.1 \
		$NEOTERM_PREFIX/share/man/man1/nc.1
}

neoterm_step_install_license() {
	mkdir -p $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME
	head -n28 netcat.c | tail -n+2 > $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/LICENSE
}
