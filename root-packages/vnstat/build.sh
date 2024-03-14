NEOTERM_PKG_HOMEPAGE=https://github.com/vergoh/vnstat
NEOTERM_PKG_DESCRIPTION="A console-based network traffic monitor"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@Denzy7"
NEOTERM_PKG_VERSION=2.12
NEOTERM_PKG_SRCURL=https://github.com/vergoh/vnstat/releases/download/v${NEOTERM_PKG_VERSION}/vnstat-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b7386b12fc1fc6f47fab31f208b12eda61862e63e229e84e95a6fa80406d2852
NEOTERM_PKG_DEPENDS="libsqlite"
NEOTERM_PKG_SERVICE_SCRIPT=("vnstat" "exec su -c \"PATH=\$PATH $NEOTERM_PREFIX/bin/vnstatd -n 2>&1\"")

# from docker root package: https://github.com/neoterm/neoterm-packages/blob/master/root-packages/docker/build.sh
neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/var/service/vnstat/
	{
		echo "#!$NEOTERM_PREFIX/bin/sh"
		echo "su -c pkill vnstatd"
	} > $NEOTERM_PREFIX/var/service/vnstat/finish
	chmod u+x $NEOTERM_PREFIX/var/service/vnstat/finish
}
