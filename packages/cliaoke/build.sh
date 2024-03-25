NEOTERM_PKG_HOMEPAGE=https://github.com/jessfraz/cliaoke
NEOTERM_PKG_DESCRIPTION="Command line karaoke"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.2.4
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/jessfraz/cliaoke/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=df601b7d118acb8c0b7251c42b5b2623335bfc51f5dc94135fa6722850955f50
NEOTERM_PKG_RECOMMENDS="fluidsynth"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang
	go mod init || :
	go mod tidy
	go mod vendor
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin cliaoke
}

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "if [ ! -e $NEOTERM_PREFIX/share/soundfonts/FluidR3_GM.sf2 ]; then" >> postinst
	echo "  echo" >> postinst
	echo "  echo You may need to get \\\`FluidR3_GM.sf2\\' from somewhere and put it into:" >> postinst
	echo "  echo" >> postinst
	echo "  echo '    '$NEOTERM_PREFIX/share/soundfonts/" >> postinst
	echo "  echo" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
