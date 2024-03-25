NEOTERM_PKG_HOMEPAGE=https://packages.debian.org/debianutils
NEOTERM_PKG_DESCRIPTION="Small utilities which are used primarily by the installation scripts of Debian packages"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.17"
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/d/debianutils/debianutils_${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=367654878388f532cd8a897fe64766e2d57ae4c60da1d4d8f20dcdf2fb0cbde8
NEOTERM_PKG_AUTO_UPDATE=true

NEOTERM_PKG_RM_AFTER_INSTALL="
bin/add-shell
bin/installkernel
bin/remove-shell
bin/update-shells
bin/which
share/man/man1/which.1
share/man/man8/add-shell.8
share/man/man8/installkernel.8
share/man/man8/remove-shell.8
share/man/man8/update-shells.8
"

neoterm_step_pre_configure() {
	autoreconf -vfi
}
