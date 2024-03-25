NEOTERM_PKG_HOMEPAGE=https://packages.debian.org/dpkg
NEOTERM_PKG_DESCRIPTION="Debian package management system"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.22.1"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://mirror.sobukus.de/files/src/dpkg//dpkg_${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=5a4824e9869494e501953c7466ab1960a7fa23d9b0b911b8a6f113094e0226cf
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="bzip2, coreutils, diffutils, gzip, less, libbz2, liblzma, libmd, tar, xz-utils, zlib, zstd"
NEOTERM_PKG_ANTI_BUILD_DEPENDS="clang"
NEOTERM_PKG_BREAKS="dpkg-dev"
NEOTERM_PKG_REPLACES="dpkg-dev"
NEOTERM_PKG_ESSENTIAL=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_selinux_setexecfilecon=no
--disable-dselect
--disable-largefile
--disable-shared
dpkg_cv_c99_snprintf=yes
HAVE_SETEXECFILECON_FALSE=#
--host=${NEOTERM_ARCH}-linux
--without-selinux
DPKG_PAGER=less
"

NEOTERM_PKG_RM_AFTER_INSTALL="
bin/dpkg-architecture
bin/dpkg-buildflags
bin/dpkg-buildpackage
bin/dpkg-checkbuilddeps
bin/dpkg-distaddfile
bin/dpkg-genbuildinfo
bin/dpkg-genchanges
bin/dpkg-gencontrol
bin/dpkg-gensymbols
bin/dpkg-maintscript-helper
bin/dpkg-mergechangelogs
bin/dpkg-name
bin/dpkg-parsechangelog
bin/dpkg-scansources
bin/dpkg-shlibdeps
bin/dpkg-source
bin/dpkg-statoverride
bin/dpkg-vendor
include
lib
share/dpkg
share/man/man1/dpkg-architecture.1
share/man/man1/dpkg-buildflags.1
share/man/man1/dpkg-buildpackage.1
share/man/man1/dpkg-checkbuilddeps.1
share/man/man1/dpkg-distaddfile.1
share/man/man1/dpkg-genbuildinfo.1
share/man/man1/dpkg-genchanges.1
share/man/man1/dpkg-gencontrol.1
share/man/man1/dpkg-gensymbols.1
share/man/man1/dpkg-maintscript-helper.1
share/man/man1/dpkg-mergechangelogs.1
share/man/man1/dpkg-name.1
share/man/man1/dpkg-parsechangelog.1
share/man/man1/dpkg-scansources.1
share/man/man1/dpkg-shlibdeps.1
share/man/man1/dpkg-source.1
share/man/man1/dpkg-statoverride.1
share/man/man1/dpkg-vendor.1
share/man/man3
share/man/man5
share/polkit-1
"

neoterm_step_pre_configure() {
	export TAR=tar # To make sure dpkg tries to use "tar" instead of e.g. "gnutar" (which happens when building on OS X)
	perl -p -i -e "s/NEOTERM_ARCH/$NEOTERM_ARCH/" $NEOTERM_PKG_SRCDIR/configure
	sed -i 's/$req_vars = \$arch_vars.$varname./if ($varname eq "DEB_HOST_ARCH_CPU" or $varname eq "DEB_HOST_ARCH"){ print("'$NEOTERM_ARCH'");exit; }; $req_vars = $arch_vars{$varname}/' scripts/dpkg-architecture.pl
}

neoterm_step_post_massage() {
	mkdir -p "${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/var/lib/dpkg/alternatives"
	mkdir -p "${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/var/lib/dpkg/info"
	mkdir -p "${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/var/lib/dpkg/triggers"
	mkdir -p "${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/var/lib/dpkg/updates"
}
