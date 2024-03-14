NEOTERM_PKG_HOMEPAGE=https://github.com/linuxhw/hw-probe
NEOTERM_PKG_DESCRIPTION="Tool to probe for hardware and check its operability"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.5
NEOTERM_PKG_SRCURL=https://github.com/linuxhw/hw-probe/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=42030ba2fb3f6fb0772ab34744fbb91a89b1b6a9b0ed99e861fa05ff86968fb1
NEOTERM_PKG_DEPENDS="curl, hwinfo, net-tools, perl"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	:
}

neoterm_step_make_install() {
	install -Dm700 hw-probe.pl "$NEOTERM_PREFIX"/bin/hw-probe
}
