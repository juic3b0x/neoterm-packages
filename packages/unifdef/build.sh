NEOTERM_PKG_HOMEPAGE=http://dotat.at/prog/unifdef/
NEOTERM_PKG_DESCRIPTION="Remove #ifdef'ed lines"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.12
NEOTERM_PKG_SRCURL=https://dotat.at/prog/unifdef/unifdef-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=fba564a24db7b97ebe9329713ac970627b902e5e9e8b14e19e024eb6e278d10b
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	mkdir -p "$NEOTERM_PREFIX"/share/man/man1/
	install -Dm700 unifdef "$NEOTERM_PREFIX"/bin/
	install -Dm600 unifdef.1 "$NEOTERM_PREFIX"/share/man/man1/
}
