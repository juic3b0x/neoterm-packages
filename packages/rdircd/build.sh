NEOTERM_PKG_HOMEPAGE=https://github.com/mk-fg/reliable-discord-client-irc-daemon
NEOTERM_PKG_DESCRIPTION="A daemon that allows using a personal Discord account through an IRC client"
NEOTERM_PKG_LICENSE="WTFPL"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=026f1aef9857ae6ce06bfb00860898e6113adfc0
NEOTERM_PKG_VERSION=2023.02.07
NEOTERM_PKG_SRCURL=git+https://github.com/mk-fg/reliable-discord-client-irc-daemon
NEOTERM_PKG_SHA256=c2cc88d6e1616d27f6f7849d536ba7613c7f13f0d16cac6022f9b1952ad537e2
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="python, python-pip"
NEOTERM_PKG_PYTHON_TARGET_DEPS="aiohttp"
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

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin rdircd
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install ${NEOTERM_PKG_PYTHON_TARGET_DEPS}
	EOF
}
