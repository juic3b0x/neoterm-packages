# x11-packages
NEOTERM_PKG_HOMEPAGE=https://github.com/a327ex/BYTEPATH
NEOTERM_PKG_DESCRIPTION="A replayable arcade shooter with a focus on build theorycrafting"
# License: MIT (assets have their own licenses)
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE, objects/modules/CreditsModule.lua"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=51ee3086ae3369a2c80e4e47d4b62d480af4fe89
NEOTERM_PKG_VERSION=2020.08.14
NEOTERM_PKG_SRCURL=git+https://github.com/a327ex/BYTEPATH
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="love10"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$NEOTERM_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$NEOTERM_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}

neoterm_step_make_install() {
	local _share_dir="$NEOTERM_PREFIX/share/bytepath"
	mkdir -p "${_share_dir}"
	find . -mindepth 1 -maxdepth 1 ! -name .git -a ! -name love \
		-exec cp -r \{\} "${_share_dir}/" \;
	local _exe="$NEOTERM_PREFIX/bin/bytepath"
	rm -rf "${_exe}"
	mkdir -p "$(dirname "${_exe}")"
	cat <<-EOF > "${_exe}"
		#!$NEOTERM_PREFIX/bin/sh
		exec $NEOTERM_PREFIX/bin/love "${_share_dir}"
	EOF
	chmod 0700 "${_exe}"
}
