NEOTERM_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/xdg-utils/
NEOTERM_PKG_DESCRIPTION="A set of simple scripts that provide basic desktop integration functions for any Free Desktop"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://gitlab.freedesktop.org/xdg/xdg-utils/-/archive/v${NEOTERM_PKG_VERSION}/xdg-utils-v${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=deac55c48aa2902023c96a4bea2f1778441ce9c59e60ed52c6ce5d8b3e90ba64
NEOTERM_PKG_DEPENDS="desktop-file-utils, file, make, perl, shared-mime-info, which, xorg-xprop"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_RM_AFTER_INSTALL="
bin/xdg-screensaver
share/man/man1/xdg-screensaver.1
"

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi
}

neoterm_step_post_make_install() {
	# `bin/xdg-open` conflicts with neoterm-tools.
	mv $NEOTERM_PREFIX/bin/{,xdg-utils-}xdg-open
	mv $NEOTERM_PREFIX/share/man/man1/{,xdg-utils-}xdg-open.1
}

neoterm_step_create_debscripts() {
	cat <<- POSTINST_EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/bash
	set -e

	echo "Sideloading Perl File::MimeInfo ..."
	cpan -fi File::MimeInfo

	exit 0
	POSTINST_EOF
}
