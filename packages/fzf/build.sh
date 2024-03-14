NEOTERM_PKG_HOMEPAGE=https://github.com/junegunn/fzf
NEOTERM_PKG_DESCRIPTION="Command-line fuzzy finder"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.47.0"
NEOTERM_PKG_SRCURL=https://github.com/junegunn/fzf/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bc566cb4630418bc9981898d3350dbfddc114637a896acaa8d818a51945bdf30
NEOTERM_PKG_AUTO_UPDATE=true

# Depend on findutils as fzf uses the -fstype option, which busybox
# find does not support, when invoking find:
NEOTERM_PKG_DEPENDS="bash, findutils, ncurses-utils, tmux"

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi
}

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR

	mkdir -p $GOPATH/src/github.com/junegunn
	mv $NEOTERM_PKG_SRCDIR $GOPATH/src/github.com/junegunn/fzf
	NEOTERM_PKG_SRCDIR=$GOPATH/src/github.com/junegunn/fzf

	cd $GOPATH/src/github.com/junegunn/fzf
	go get -d -v github.com/junegunn/fzf
	go build
}

neoterm_step_make_install() {
	cd $GOPATH/src/github.com/junegunn/fzf

	install -Dm700 fzf $NEOTERM_PREFIX/bin/fzf

	# Install fzf-tmux, a bash script for launching fzf in a tmux pane:
	install -Dm700 $NEOTERM_PKG_SRCDIR/bin/fzf-tmux $NEOTERM_PREFIX/bin/fzf-tmux

	# Install the fzf.1 man page:
	mkdir -p $NEOTERM_PREFIX/share/man/man1/
	cp $NEOTERM_PKG_SRCDIR/man/man1/fzf.1 $NEOTERM_PREFIX/share/man/man1/

	# Install the rest of the shell scripts:
	mkdir -p $NEOTERM_PREFIX/share/fzf
	cp $NEOTERM_PKG_SRCDIR/shell/* $NEOTERM_PREFIX/share/fzf/
	
	# Symlink shell completions.
	mkdir -p $NEOTERM_PREFIX/share/bash-completion/completions/
	ln -sfr $NEOTERM_PREFIX/share/fzf/completion.bash $NEOTERM_PREFIX/share/bash-completion/completions/fzf
	mkdir -p $NEOTERM_PREFIX/share/zsh/site-functions
	ln -sfr $NEOTERM_PREFIX/share/fzf/completion.zsh $NEOTERM_PREFIX/share/zsh/site-functions/_fzf
	
	# Fish keybindings.
	mkdir -p $NEOTERM_PREFIX/share/fish/vendor_functions.d
	ln -sfr $NEOTERM_PREFIX/share/fzf/key-bindings.fish $NEOTERM_PREFIX/share/fish/vendor_functions.d/fzf_key_bindings.fish

	# Install the nvim plugin:
	mkdir -p $NEOTERM_PREFIX/share/nvim/runtime/plugin
	cp $NEOTERM_PKG_SRCDIR/plugin/fzf.vim $NEOTERM_PREFIX/share/nvim/runtime/plugin/
}
