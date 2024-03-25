NEOTERM_PKG_HOMEPAGE=https://www.gnu.org.ua/software/direvent/
NEOTERM_PKG_DESCRIPTION="Monitor of events in file system directories"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.3
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/direvent/direvent-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9405a8a77da49fe92bbe4af18bf925ff91f6d3374c10b7d700a031bacb94c497
NEOTERM_PKG_DEPENDS="libandroid-glob"

neoterm_step_pre_configure() {
	export LIBS="-landroid-glob"
}
