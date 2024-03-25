NEOTERM_PKG_HOMEPAGE=https://sabnzbd.org/
NEOTERM_PKG_DESCRIPTION="Fully automated Usenet Binary Downloader"
NEOTERM_PKG_LICENSE="GPL-2.0, GPL-3.0"
NEOTERM_PKG_LICENSE_FILE="LICENSE.txt, GPL2.txt, GPL3.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.2.3"
NEOTERM_PKG_SRCURL=https://github.com/sabnzbd/sabnzbd/releases/download/${NEOTERM_PKG_VERSION}/SABnzbd-${NEOTERM_PKG_VERSION}-src.tar.gz
NEOTERM_PKG_SHA256=f16314cf4032dcaccfd0b4af4d0e67a55c37f31870af3ca90f80d5f547ed8c25
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="python, python-cryptography, python-sabyenc3, neoterm-tools, par2, unrar, p7zip, unzip"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_SERVICE_SCRIPT=("sabnzbd" 'exec sabnzbd -d 2>&1')
NEOTERM_PKG_PYTHON_TARGET_DEPS="'cheetah3==3.2.6.post1', 'cffi==1.15.1', 'pycparser==2.21', 'feedparser==6.0.10', 'configobj==5.0.8', 'cheroot==10.0.0', 'six==1.16.0', 'cherrypy==18.8.0', 'jaraco.functools==3.6.0', 'jaraco.collections==4.1.0', 'jaraco.text==3.8.1', 'jaraco.classes==3.2.3', 'jaraco.context==4.3.0', 'more-itertools==9.1.0', 'zc.lockfile==3.0.post1', 'python-dateutil==2.8.2', 'tempora==5.2.2', 'pytz==2023.3', 'sgmllib3k==1.0.0', 'portend==3.1.0', 'chardet==5.1.0', 'PySocks==1.7.1', 'puremagic==1.15', 'guessit==3.7.1', 'babelfish==0.6.0', 'rebulk==3.2.0'"

neoterm_step_make_install() {
	local sabnzbd="${NEOTERM_PREFIX}/share/sabnzbd"
	mkdir -p "${sabnzbd}"
	cp -r email icons interfaces locale po sabnzbd scripts tools "${sabnzbd}"
	find "${sabnzbd}" -type d -exec chmod 700 {} \;
	find "${sabnzbd}" -type f -exec chmod 600 {} \;
	install -Dm700 SABnzbd.py "${NEOTERM_PREFIX}/bin/sabnzbd"
	install -Dm600 linux/sabnzbd.bash-completion "${NEOTERM_PREFIX}/share/bash-completion/completions/sabnzbd"
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install ${NEOTERM_PKG_PYTHON_TARGET_DEPS//, / }
	EOF
}
