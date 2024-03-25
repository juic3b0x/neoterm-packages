NEOTERM_PKG_HOMEPAGE=https://github.com/MrJoy/ssss
NEOTERM_PKG_DESCRIPTION="Simple command-line implementation of Shamir's Secret Sharing Scheme"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.5.7
NEOTERM_PKG_SRCURL=https://github.com/MrJoy/ssss/archive/releases/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=dbb1f03797cb3fa69594530f9b2c36010f66705b9d5fbbc27293dce72b9c9473
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libgmp"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	install -Dm700 ssss-split "$NEOTERM_PREFIX"/bin/
	ln -sfr "$NEOTERM_PREFIX"/bin/ssss-split $NEOTERM_PREFIX/bin/ssss-combine

	install -Dm600 ssss.1 "$NEOTERM_PREFIX"/share/man/man1/ssss.1
	ln -sfr \
		"$NEOTERM_PREFIX"/share/man/man1/ssss.1 \
		"$NEOTERM_PREFIX"/share/man/man1/ssss-combine.1
	ln -sfr \
		"$NEOTERM_PREFIX"/share/man/man1/ssss.1 \
		"$NEOTERM_PREFIX"/share/man/man1/ssss-split.1
}
