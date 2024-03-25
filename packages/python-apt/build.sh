NEOTERM_PKG_HOMEPAGE=https://apt-team.pages.debian.net/python-apt/
NEOTERM_PKG_DESCRIPTION="Python bindings for APT"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.7.2"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://ftp.debian.org/debian/pool/main/p/python-apt/python-apt_${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=00371ae55d7ebc5fea3b4973f440e0f3683afbe1af7e969706a28c60b47a34d9
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="apt, build-essential, libc++, python, texinfo"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"

neoterm_step_pre_configure() {
	export DEBVER="${NEOTERM_PKG_VERSION#*:}"
}
