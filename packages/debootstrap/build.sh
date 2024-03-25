NEOTERM_PKG_HOMEPAGE=https://wiki.debian.org/Debootstrap
NEOTERM_PKG_DESCRIPTION="Bootstrap a basic Debian system"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="debian/copyright"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.0.134"
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/d/debootstrap/debootstrap_${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=03c1dfbff2f9936acea3954b9c92e348e7e216f706c202744f80c9f1302329b4
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="binutils | binutils-is-llvm, perl, proot, sed, wget"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make() {
    :
}

neoterm_step_make_install() {
	find ${NEOTERM_PKG_SRCDIR}/.. -name "*.orig" -delete

	local VERSION=$(sed 's/.*(\(.*\)).*/\1/; q' debian/changelog)
	mkdir -p ${NEOTERM_PREFIX}/share/debootstrap/scripts
	cp -a scripts/* ${NEOTERM_PREFIX}/share/debootstrap/scripts/
	install -m 0644 functions ${NEOTERM_PREFIX}/share/debootstrap/
	sed "s/@VERSION@/${VERSION}/g" debootstrap > ${NEOTERM_PREFIX}/bin/debootstrap
	chmod 0755 ${NEOTERM_PREFIX}/bin/debootstrap

	mkdir -p ${NEOTERM_PREFIX}/share/man/man8/
	install ${NEOTERM_PKG_SRCDIR}/debootstrap.8 ${NEOTERM_PREFIX}/share/man/man8/
}
