NEOTERM_PKG_HOMEPAGE=http://www-zeuthen.desy.de/~friebel/unix/lesspipe.html
NEOTERM_PKG_DESCRIPTION="An input filter for the pager less"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.11"
NEOTERM_PKG_SRCURL=https://github.com/wofr06/lesspipe/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8e8eebf80f8a249c49b31e775728f4d3062f0a97ff7ef7363ccba522f51ffa3c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="less"
NEOTERM_PKG_BUILD_DEPENDS="bash-completion"
NEOTERM_PKG_SUGGESTS="imagemagick, p7zip, unrar, unzip"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	./configure \
		--prefix="$NEOTERM_PREFIX"
}

neoterm_step_post_make_install() {
	mkdir -p "$NEOTERM_PREFIX"/etc/profile.d
	echo "export LESSOPEN='|$NEOTERM_PREFIX/bin/lesspipe.sh %s'" \
		> "$NEOTERM_PREFIX"/etc/profile.d/lesspipe.sh
}
