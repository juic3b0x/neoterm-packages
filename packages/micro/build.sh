NEOTERM_PKG_HOMEPAGE=https://micro-editor.github.io/
NEOTERM_PKG_DESCRIPTION="Modern and intuitive terminal-based text editor"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.0.13"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SRCURL=git+https://github.com/zyedidia/micro

neoterm_step_make() {
	return
}

neoterm_step_make_install() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	local MICRO_SRC=$GOPATH/src/github.com/zyedidia/micro

	cd $NEOTERM_PKG_SRCDIR
	mkdir -p $MICRO_SRC
	cp -R . $MICRO_SRC

	cd $MICRO_SRC
	make build
	mv micro $NEOTERM_PREFIX/bin/micro
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/editor editor $NEOTERM_PREFIX/bin/micro 25
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $NEOTERM_PREFIX/bin/micro
		fi
	fi
	EOF
}
