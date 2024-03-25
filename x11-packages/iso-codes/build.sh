NEOTERM_PKG_HOMEPAGE=https://salsa.debian.org/iso-codes-team/iso-codes
NEOTERM_PKG_DESCRIPTION="Lists of the country, language, and currency names"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.15.0
NEOTERM_PKG_SRCURL=https://salsa.debian.org/iso-codes-team/iso-codes/-/archive/v${NEOTERM_PKG_VERSION}/iso-codes-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b83b54b9d7dd6eb877380b3ec46f370b05daf2cbfa131c612f03598d654c0ef8
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

#If you install ISO codes over a previous installed version, the install step will fail when creating some symlinks

neoterm_step_post_configure() {
	sed -i '/^LN_S/s/s/sfvn/' */Makefile
}
