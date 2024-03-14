NEOTERM_PKG_HOMEPAGE=https://ccid.apdu.fr/
NEOTERM_PKG_DESCRIPTION="A generic USB CCID (Chip/Smart Card Interface Devices) driver and ICCD (Integrated Circuit(s) Card Devices)."
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.4
NEOTERM_PKG_SRCURL=https://ccid.apdu.fr/files/ccid-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=6e832adc172ecdcfdee2b56f33144684882cbe972daff1938e7a9c73a64f88bf
NEOTERM_PKG_DEPENDS="libusb, pcscd"
NEOTERM_PKG_BUILD_DEPENDS="libpcsclite, flex"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
"
