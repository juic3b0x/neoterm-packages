NEOTERM_PKG_HOMEPAGE=https://github.com/jeaye/stdman
NEOTERM_PKG_DESCRIPTION="Formatted C++20 stdlib man pages (cppreference)"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2022.07.30
NEOTERM_PKG_SRCURL=https://github.com/jeaye/stdman/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=332383e5999e1ac9a6210be8b256608187bb7690a2bff990372e93c2ad4e76ff
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="man"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make() {
	# Just install manpages without building generation utility.
	:
}
