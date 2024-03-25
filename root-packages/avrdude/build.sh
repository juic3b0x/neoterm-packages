NEOTERM_PKG_HOMEPAGE=https://avrdudes.github.io/avrdude/
NEOTERM_PKG_DESCRIPTION="Software for programming Microchip (former Atmel) AVR Microcontrollers"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=7.3
NEOTERM_PKG_SRCURL=https://github.com/avrdudes/avrdude/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1c61ae67aacf8b8ccae5741f987ba4b0c48d6e320405520352a8eca8c6e2c457
NEOTERM_PKG_DEPENDS="libusb"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"
