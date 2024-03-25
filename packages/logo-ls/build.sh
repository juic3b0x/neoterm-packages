NEOTERM_PKG_HOMEPAGE=https://github.com/Yash-Handa/logo-ls
NEOTERM_PKG_DESCRIPTION="Modern ls command with vscode like File Icon and Git Integrations"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=96bd6044d7a5270bd32458a7d0f38caf7fd5ee53
NEOTERM_PKG_VERSION="2023.08.18"
NEOTERM_PKG_SRCURL=git+https://github.com/canta2899/logo-ls
NEOTERM_PKG_SHA256=2e86813bd10113c7b69fd5914dcd18ead4eb4dda9b50d951c5380cbf4a685e79
NEOTERM_PKG_GIT_BRANCH="main"
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

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy 
}

neoterm_step_make() {
	go build -o logo-ls
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin logo-ls
}

neoterm_step_create_debscripts() {                   
	cat <<- POSTINST_EOF > ./postinst           
	#!$NEOTERM_PREFIX/bin/sh
	echo "Please change font from neoterm-styling addon"
	POSTINST_EOF
}
