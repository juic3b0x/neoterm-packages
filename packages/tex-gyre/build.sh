NEOTERM_PKG_HOMEPAGE=https://www.gust.org.pl/projects/e-foundry/tex-gyre/
NEOTERM_PKG_DESCRIPTION="The TeX Gyre (TG) Collection of Fonts"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="GUST-FONT-LICENSE.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.501
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.gust.org.pl/projects/e-foundry/tex-gyre/whole/tg${NEOTERM_PKG_VERSION//./_}otf.zip
NEOTERM_PKG_SHA256=d7f8be5317bec4e644cf16c5abf876abeeb83c43dbec0ccb4eee4516b73b1bbe
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	neoterm_download https://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt \
		$NEOTERM_PKG_SRCDIR/GUST-FONT-LICENSE.txt \
		a746108477b2fa685845e7596b7ad8342bc358704b2b7da355f2df0a0cb8ad85
}

neoterm_step_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/share/fonts/tex-gyre *.otf
}
