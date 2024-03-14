NEOTERM_PKG_HOMEPAGE=https://github.com/logrotate/logrotate
NEOTERM_PKG_DESCRIPTION="Simplify the administration of log files on a system which generates a lot of log files"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.21.0"
NEOTERM_PKG_SRCURL=https://github.com/logrotate/logrotate/releases/download/${NEOTERM_PKG_VERSION}/logrotate-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=8fa12015e3b8415c121fc9c0ca53aa872f7b0702f543afda7e32b6c4900f6516
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libpopt, libandroid-glob"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
