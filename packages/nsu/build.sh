TERMUX_PKG_HOMEPAGE=https://github.com/juic3b0x/nsu
TERMUX_PKG_DESCRIPTION="A su wrapper for NeoTerm"
TERMUX_PKG_LICENSE="ISC"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION=8.6.0
_COMMIT=3f5f3c4a475836f854d49c0576c1177edd03ff57
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_SRCURL=git+https://github.com/juic3b0x/nsu
TERMUX_PKG_GIT_BRANCH=v8

termux_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT
}

termux_step_make() {
	python3 ./extract_usage.py
}

termux_step_make_install() {
	# There is no install.sh script in the repository for now
	mkdir -p "$TERMUX_PREFIX/bin"
	install -Dm755 nsu "$TERMUX_PREFIX/bin"
	# sudo - is an included addon in nsu now
	ln -sf "$TERMUX_PREFIX/bin/nsu" "$TERMUX_PREFIX/bin/sudo"
}
