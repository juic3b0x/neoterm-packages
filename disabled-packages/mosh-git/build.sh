NEOTERM_PKG_HOMEPAGE=https://mosh.org
NEOTERM_PKG_DESCRIPTION="Mobile shell that supports roaming and intelligent local echo. Bleeding edge git version."
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2022.02.04
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_SRCURL=git+https://github.com/mobile-shell/mosh
NEOTERM_PKG_DEPENDS="libandroid-support, libc++, libprotobuf, ncurses, openssl, openssh, perl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_CONFLICTS="mosh, mosh-perl"
NEOTERM_PKG_REPLACES="mosh, mosh-perl"
NEOTERM_PKG_PROVIDES="mosh, mosh-perl"
_COMMIT=dbe419d0e069df3fedc212d456449f64d0280c76

neoterm_step_pre_configure() {
	neoterm_setup_protobuf
	./autogen.sh
}

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout "$_COMMIT"

	local version
	version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$NEOTERM_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$NEOTERM_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}
