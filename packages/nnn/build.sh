NEOTERM_PKG_HOMEPAGE=https://github.com/jarun/nnn
NEOTERM_PKG_DESCRIPTION="Free, fast, friendly file browser"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.9"
NEOTERM_PKG_SRCURL=https://github.com/jarun/nnn/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9e25465a856d3ba626d6163046669c0d4010d520f2fb848b0d611e1ec6af1b22
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="file, findutils, readline, wget, libandroid-support, lzip"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_make_install() {
	install -Dm600 misc/auto-completion/bash/nnn-completion.bash \
		$NEOTERM_PREFIX/share/bash-completion/completions/nnn
	install -Dm600 misc/auto-completion/fish/nnn.fish \
		$NEOTERM_PREFIX/share/fish/vendor_completions.d/nnn.fish
	install -Dm600 misc/auto-completion/zsh/_nnn \
		$NEOTERM_PREFIX/share/zsh/site-functions/_nnn
}
