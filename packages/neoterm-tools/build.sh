TERMUX_PKG_HOMEPAGE=https://neoterm.org
TERMUX_PKG_DESCRIPTION="Basic system tools for NeoTerm"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION="1.41.1"
TERMUX_PKG_SRCURL=https://repo.theworkjoy.com/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=a05da53ac86e75602a0bd9dabc224c3f57a3fcec565ed30987b72a13a336c614
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_ESSENTIAL=true
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_TAG_TYPE="newest-tag"
TERMUX_PKG_BREAKS="neoterm-keyring (<< 1.9)"
TERMUX_PKG_CONFLICTS="procps (<< 3.3.15-2)"
TERMUX_PKG_SUGGESTS="termux-api"

# Some of these packages are not dependencies and used only to ensure
# that core packages are installed after upgrading (we removed busybox
# from essentials).
TERMUX_PKG_DEPENDS="bzip2, coreutils, curl, dash, diffutils, findutils, gawk, grep, gzip, less, procps, psmisc, sed, tar, termux-am (>= 0.8.0), termux-am-socket (>= 1.5.0), neoterm-exec, util-linux, xz-utils, dialog"

# Optional packages that are distributed as part of bootstrap archives.
TERMUX_PKG_RECOMMENDS="ed, dos2unix, inetutils, net-tools, patch, unzip"

termux_step_pre_configure() {
	autoreconf -vfi
}

termux_step_post_make_install() {
	TERMUX_PKG_CONFFILES="$(cat "$TERMUX_PKG_BUILDDIR/conffiles")"
}

termux_step_create_debscripts() {
	cat <<- EOF > ./preinst
	$(cat "$TERMUX_PKG_BUILDDIR/preinst")
	EOF
}
