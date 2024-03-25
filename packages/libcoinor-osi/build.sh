NEOTERM_PKG_HOMEPAGE=https://github.com/coin-or/Osi
NEOTERM_PKG_DESCRIPTION="An abstract base class to a generic linear programming (LP) solver"
NEOTERM_PKG_LICENSE="EPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:0.108.8
NEOTERM_PKG_SRCURL=https://github.com/coin-or/Osi/archive/refs/tags/releases/${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=8b01a49190cb260d4ce95aa7e3948a56c0917b106f138ec0a8544fadca71cf6a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libc++, libcoinor-utils"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
