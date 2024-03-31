NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/neoterm-tools
NEOTERM_PKG_DESCRIPTION="Basic system tools for NeoTerm"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.41.3"
NEOTERM_PKG_SRCURL=https://github.com/juic3b0x/neoterm-tools/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=418d2940280f8fd8fdbe04a8ba90e3002d4e78ddf70229136486678d377c9479
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_ESSENTIAL=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_BREAKS="neoterm-keyring (<< 1.9)"
NEOTERM_PKG_CONFLICTS="procps (<< 3.3.15-2)"
NEOTERM_PKG_SUGGESTS="neoterm-api"

# Some of these packages are not dependencies and used only to ensure
# that core packages are installed after upgrading (we removed busybox
# from essentials).
NEOTERM_PKG_DEPENDS="bzip2, coreutils, curl, dash, diffutils, findutils, gawk, grep, gzip, less, procps, psmisc, sed, tar, neoterm-am (>= 0.8.0), neoterm-am-socket (>= 1.5.0), neoterm-exec, util-linux, xz-utils, dialog"

# Optional packages that are distributed as part of bootstrap archives.
NEOTERM_PKG_RECOMMENDS="ed, dos2unix, inetutils, net-tools, patch, unzip"

neoterm_step_pre_configure() {
	autoreconf -vfi
}

neoterm_step_post_make_install() {
	NEOTERM_PKG_CONFFILES="$(cat "$NEOTERM_PKG_BUILDDIR/conffiles")"
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./preinst
	$(cat "$NEOTERM_PKG_BUILDDIR/preinst")
	EOF
}
