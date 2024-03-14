NEOTERM_SUBPKG_INCLUDE="bin/ share/man/man1/"
NEOTERM_SUBPKG_DESCRIPTION="Simple, extensible, embeddable programming language"
NEOTERM_SUBPKG_DEPENDS="readline"

neoterm_step_create_subpkg_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/lua lua $NEOTERM_PREFIX/bin/lua5.4 140
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/luac luac $NEOTERM_PREFIX/bin/luac5.4 140
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove lua $NEOTERM_PREFIX/bin/lua
			update-alternatives --remove luac $NEOTERM_PREFIX/bin/luac
		fi
	fi
	EOF
}
