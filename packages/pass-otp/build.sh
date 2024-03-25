NEOTERM_PKG_HOMEPAGE=https://github.com/tadfisher/pass-otp
NEOTERM_PKG_DESCRIPTION="A pass extension for managing one-time-password (OTP) tokens"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION=1.2.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/tadfisher/pass-otp/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5720a649267a240a4f7ba5a6445193481070049c1d08ba38b00d20fc551c3a67
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="oathtool, pass"
NEOTERM_PKG_SUGGESTS="libqrencode"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_pre_configure() {
	export BASHCOMPDIR=$NEOTERM_PREFIX/etc/bash_completion.d
}
