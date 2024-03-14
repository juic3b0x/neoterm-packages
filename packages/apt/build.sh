NEOTERM_PKG_HOMEPAGE=https://packages.debian.org/apt
NEOTERM_PKG_DESCRIPTION="Front-end for the dpkg package manager"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.7.10"
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/a/apt/apt_${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=55466c484aa64097ac20f538b4ae042e7f62e6116205418d11ea4fc9221d807e
# apt-key requires utilities from coreutils, findutils, gpgv, grep, sed.
NEOTERM_PKG_DEPENDS="coreutils, dpkg, findutils, gpgv, grep, libandroid-glob, libbz2, libc++, libcurl, libgnutls, liblz4, liblzma, sed, neoterm-keyring, neoterm-licenses, xxhash, zlib, zstd"
NEOTERM_PKG_BUILD_DEPENDS="docbook-xsl"
NEOTERM_PKG_CONFLICTS="apt-transport-https, libapt-pkg, unstable-repo, game-repo, science-repo"
NEOTERM_PKG_REPLACES="apt-transport-https, libapt-pkg, unstable-repo, game-repo, science-repo"
NEOTERM_PKG_PROVIDES="unstable-repo, game-repo, science-repo"
NEOTERM_PKG_SUGGESTS="gnupg"
NEOTERM_PKG_ESSENTIAL=true

NEOTERM_PKG_CONFFILES="
etc/apt/sources.list
"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DPERL_EXECUTABLE=$(command -v perl)
-DCMAKE_INSTALL_FULL_LOCALSTATEDIR=$NEOTERM_PREFIX
-DCACHE_DIR=${NEOTERM_CACHE_DIR}/apt
-DCOMMON_ARCH=$NEOTERM_ARCH
-DDPKG_DATADIR=$NEOTERM_PREFIX/share/dpkg
-DUSE_NLS=OFF
-DWITH_DOC=OFF
-DWITH_DOC_MANPAGES=ON
"

# ubuntu uses instead $PREFIX/lib instead of $PREFIX/libexec to
# "Work around bug in GNUInstallDirs" (from apt 1.4.8 CMakeLists.txt).
# Archlinux uses $PREFIX/libexec though, so let's force libexec->lib to
# get same build result on ubuntu and archlinux.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="-DCMAKE_INSTALL_LIBEXECDIR=lib"

NEOTERM_PKG_RM_AFTER_INSTALL="
bin/apt-cdrom
bin/apt-extracttemplates
bin/apt-sortpkgs
etc/apt/apt.conf.d
lib/apt/methods/cdrom
lib/apt/methods/mirror*
lib/apt/methods/rred
lib/apt/planners/
lib/apt/solvers/
lib/dpkg/
share/man/man1/apt-extracttemplates.1
share/man/man1/apt-sortpkgs.1
share/man/man1/apt-transport-mirror.1
share/man/man8/apt-cdrom.8
"

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# Fix i686 builds.
	CXXFLAGS+=" -Wno-c++11-narrowing"
	# Fix glob() on Android 7.
	LDFLAGS+=" -Wl,--no-as-needed -landroid-glob"

	# for manpage build
	local docbook_xsl_version=$(. $NEOTERM_SCRIPTDIR/packages/docbook-xsl/build.sh; echo $NEOTERM_PKG_VERSION)
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DDOCBOOK_XSL=$NEOTERM_PREFIX/share/xml/docbook/xsl-stylesheets-$docbook_xsl_version-nons"
}

neoterm_step_post_make_install() {
	{
		echo "# The main neoterm repository, with cloudflare cache"
		echo "deb https://packages-cf.neoterm.dev/apt/neoterm-main/ stable main"
		echo "# The main neoterm repository, without cloudflare cache"
		echo "# deb https://packages.neoterm.dev/apt/neoterm-main/ stable main"
	} > $NEOTERM_PREFIX/etc/apt/sources.list

	# apt-transport-tor
	ln -sfr $NEOTERM_PREFIX/lib/apt/methods/http $NEOTERM_PREFIX/lib/apt/methods/tor
	ln -sfr $NEOTERM_PREFIX/lib/apt/methods/http $NEOTERM_PREFIX/lib/apt/methods/tor+http
	ln -sfr $NEOTERM_PREFIX/lib/apt/methods/https $NEOTERM_PREFIX/lib/apt/methods/tor+https
	# Workaround for "empty" subpackage:
	local dir=$NEOTERM_PREFIX/share/apt-transport-tor
	mkdir -p $dir
	touch $dir/.placeholder
}
