NEOTERM_PKG_HOMEPAGE=https://github.com/nfc-tools/libnfc
NEOTERM_PKG_DESCRIPTION="Free/Libre Near Field Communication (NFC) library"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.8.0
NEOTERM_PKG_SRCURL=https://github.com/nfc-tools/libnfc/releases/download/libnfc-${NEOTERM_PKG_VERSION}/libnfc-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=6d9ad31c86408711f0a60f05b1933101c7497683c2e0d8917d1611a3feba3dd5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-drivers=acr122s,arygon,pn532_uart,pn532_spi,pn532_i2c
"
