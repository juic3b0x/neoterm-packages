NEOTERM_PKG_HOMEPAGE=https://github.com/gokcehan/lf
NEOTERM_PKG_DESCRIPTION="Terminal file manager"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="31"
NEOTERM_PKG_SRCURL=https://github.com/gokcehan/lf/archive/r$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=ed47fc22c58cf4f4e4116a58c500bdb9f9ccc0b89f87be09f321e8d1431226ab
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+"
NEOTERM_PKG_CONFFILES="etc/lf/lfrc"

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH="$NEOTERM_PKG_BUILDDIR"
	mkdir -p "$GOPATH/src/github.com/gokcehan"
	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH/src/github.com/gokcehan/lf"
	cd "$GOPATH/src/github.com/gokcehan/lf"
	go build -ldflags="-X main.gVersion=r$NEOTERM_PKG_VERSION" -trimpath
}

neoterm_step_make_install() {
	cd "$GOPATH/src/github.com/gokcehan/lf"
	install -Dm755 -t "$NEOTERM_PREFIX/bin" lf
	install -Dm644 -T etc/lfrc.example "$NEOTERM_PREFIX/etc/lf/lfrc"
	install -Dm644 -t "$NEOTERM_PREFIX/share/applications" lf.desktop
	install -Dm644 -t "$NEOTERM_PREFIX/share/doc/lf" README.md
	install -Dm644 -t "$NEOTERM_PREFIX/share/man/man1" lf.1
	# bash integration
	install -Dm644 -t "$NEOTERM_PREFIX/etc/profile.d" etc/lfcd.sh
	# csh integration
	install -Dm644 -t "$NEOTERM_PREFIX/etc/profile.d" etc/lf.csh etc/lfcd.csh
	# fish integration
	install -Dm644 -t "$NEOTERM_PREFIX/share/fish/vendor_functions.d" etc/lfcd.fish
	install -Dm644 -t "$NEOTERM_PREFIX/share/fish/vendor_completions.d" etc/lf.fish
	# vim integration
	install -Dm644 -t "$NEOTERM_PREFIX/share/vim/vimfiles/plugin" etc/lf.vim
	# zsh integration
	install -Dm644 -T etc/lfcd.sh "$NEOTERM_PREFIX/share/zsh/site-functions/lfcd"
	install -Dm644 -T etc/lf.zsh "$NEOTERM_PREFIX/share/zsh/site-functions/_lf"
}
