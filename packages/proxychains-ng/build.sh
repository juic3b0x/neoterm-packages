NEOTERM_PKG_HOMEPAGE=https://github.com/rofl0r/proxychains-ng
NEOTERM_PKG_DESCRIPTION="A hook preloader that allows to redirect TCP traffic of existing dynamically linked programs through one or more SOCKS or HTTP proxies"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.17
NEOTERM_PKG_SRCURL=https://github.com/rofl0r/proxychains-ng/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=1a2dc68fcbcb2546a07a915343c1ffc75845f5d9cc3ea5eb3bf0b62a66c0196f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi
}

neoterm_step_post_make_install() {
	# Remove conf file from previous build, otherwise nothing will be done and it won't be included in the package
	rm -f "$NEOTERM_PREFIX"/etc/proxychains.conf
	make install-config
}
