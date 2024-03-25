NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/nsu
NEOTERM_PKG_DESCRIPTION="A su wrapper for NeoTerm"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=8.6.0
_COMMIT=3f5f3c4a475836f854d49c0576c1177edd03ff57
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_SRCURL=git+https://github.com/juic3b0x/nsu
NEOTERM_PKG_GIT_BRANCH=v8

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT
}

neoterm_step_make() {
	python3 ./extract_usage.py
}

neoterm_step_make_install() {
	# There is no install.sh script in the repository for now
	mkdir -p "$NEOTERM_PREFIX/bin"
	install -Dm755 nsu "$NEOTERM_PREFIX/bin"
	# sudo - is an included addon in nsu now
	ln -sf "$NEOTERM_PREFIX/bin/nsu" "$NEOTERM_PREFIX/bin/sudo"
}
