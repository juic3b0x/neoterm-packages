NEOTERM_PKG_HOMEPAGE=https://www.rodsbooks.com/gdisk/
NEOTERM_PKG_DESCRIPTION="A text-mode partitioning tool that works on GUID Partition Table (GPT) disks"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.9
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://sourceforge.net/projects/gptfdisk/files/gptfdisk/$NEOTERM_PKG_VERSION/gptfdisk-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=dafead2693faeb8e8b97832b23407f6ed5b3219bc1784f482dd855774e2d50c2
NEOTERM_PKG_DEPENDS="libc++, libpopt, ncurses"
NEOTERM_PKG_BUILD_DEPENDS="libuuid"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	install -d "$NEOTERM_PREFIX"/{bin,share/{doc/gdisk,man/man8}}
	install -t "$NEOTERM_PREFIX"/bin/ {,c,s}gdisk fixparts
	install -m600 -t "$NEOTERM_PREFIX"/share/man/man8/ {{,c,s}gdisk,fixparts}.8
}
