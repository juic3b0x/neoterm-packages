NEOTERM_PKG_HOMEPAGE=https://apt-team.pages.debian.net/python-apt/
NEOTERM_PKG_DESCRIPTION="Python bindings for APT"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.7.2"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://repo.theworkjoy.com/python-apt_${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=9dbdb95f735da7c42615b30d47d0e271724cfabd960d943038cd6664c02a9ddd
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="apt, build-essential, libc++, python, texinfo"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"

neoterm_step_pre_configure() {
	export DEBVER="${NEOTERM_PKG_VERSION#*:}"
}
