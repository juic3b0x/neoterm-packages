NEOTERM_PKG_HOMEPAGE=https://www.tug.org/texlive/
NEOTERM_PKG_DESCRIPTION="Wrapper around texlive's install-tl script"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION=20230313
NEOTERM_PKG_SRCURL=https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/${NEOTERM_PKG_VERSION:0:4}/install-tl-unx.tar.gz
NEOTERM_PKG_SHA256=d97bdb3b1903428e56373e70861b24db448243d74d950cdff96f4e888f008605
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_DEPENDS="perl, texlive-bin (>= 20200406-4), gnupg, curl, lz4, xz-utils"
NEOTERM_PKG_REPLACES="texlive"
NEOTERM_PKG_BREAKS="texlive"
NEOTERM_PKG_RM_AFTER_INSTALL="
opt/texlive/install-tl/texmf-dist
opt/texlive/install-tl/tlpkg/installer/curl
opt/texlive/install-tl/tlpkg/installer/wget
opt/texlive/install-tl/tlpkg/installer/xz
"

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/opt/texlive
	sed -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
		"$NEOTERM_PKG_BUILDER_DIR"/installer.sh \
		> $NEOTERM_PREFIX/bin/neoterm-install-tl
	chmod 700 $NEOTERM_PREFIX/bin/neoterm-install-tl

	sed -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
		"$NEOTERM_PKG_BUILDER_DIR"/neoterm-patch-texlive.sh \
		> $NEOTERM_PREFIX/bin/neoterm-patch-texlive
	chmod 700 $NEOTERM_PREFIX/bin/neoterm-patch-texlive

	sed -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
		-e "s|@YEAR@|${NEOTERM_PKG_VERSION:0:4}|g" \
		"$NEOTERM_PKG_BUILDER_DIR"/neoterm.profile \
		> $NEOTERM_PREFIX/opt/texlive/neoterm.profile
	chmod 600 $NEOTERM_PREFIX/opt/texlive/neoterm.profile

	for DIFF in "$NEOTERM_PKG_BUILDER_DIR"/*.diff; do
		sed -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" $DIFF \
			> $NEOTERM_PREFIX/opt/texlive/$(basename $DIFF)
		chmod 600 $NEOTERM_PREFIX/opt/texlive/$(basename $DIFF)
	done

	if [ -d "$NEOTERM_PREFIX/opt/texlive/install-tl" ]; then
		rm -r "$NEOTERM_PREFIX/opt/texlive/install-tl"
	fi
	cp -r $NEOTERM_PKG_SRCDIR/ $NEOTERM_PREFIX/opt/texlive/install-tl

	mkdir -p $NEOTERM_PREFIX/etc/profile.d/
	{
		echo "export PATH=\$PATH:$NEOTERM_PREFIX/bin/texlive"
		echo "export TEXMFROOT=$NEOTERM_PREFIX/share/texlive"
		echo "export TEXMFLOCAL=$NEOTERM_PREFIX/share/texlive/texmf-local"
		echo "export OSFONTDIR=$NEOTERM_PREFIX/share/fonts/TTF"
		echo "export TRFONTS=$NEOTERM_PREFIX/share/groff/{current/font,site-font}/devps"
	} > $NEOTERM_PREFIX/etc/profile.d/texlive.sh
}

neoterm_step_create_debscripts() {
	{
		echo "#!$NEOTERM_PREFIX/bin/sh"
		echo "echo ''"
		echo "echo '[*] You can now run the texlive installer by running'"
		echo "echo ''"
		echo "echo '      neoterm-install-tl'"
		echo "echo ''"
		echo "echo '    It forwards extra arguments to the install-tl script.'"
	} > ./postinst
}
