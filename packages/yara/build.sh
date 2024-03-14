NEOTERM_PKG_HOMEPAGE=https://github.com/VirusTotal/yara
NEOTERM_PKG_DESCRIPTION="Tool aimed at helping malware researchers to identify and classify malware samples"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.5.0"
NEOTERM_PKG_SRCURL=https://github.com/VirusTotal/yara/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=f6db34bd102703bf56cc2878ddfb249c3fb2e09c9194d3adb78c3ab79282c827
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="file, openssl, libandroid-posix-semaphore"
NEOTERM_PKG_BREAKS="yara-dev"
NEOTERM_PKG_REPLACES="yara-dev"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-posix-semaphore"
	./bootstrap.sh
}
