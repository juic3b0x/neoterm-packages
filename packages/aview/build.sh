NEOTERM_PKG_HOMEPAGE=https://aa-project.sourceforge.net/aview/
NEOTERM_PKG_DESCRIPTION="High quality ascii-art image browser and animation player"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.0rc1
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/aa-project/aview/aview-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=42d61c4194e8b9b69a881fdde698c83cb27d7eda59e08b300e73aaa34474ec99
NEOTERM_PKG_DEPENDS="aalib (>> 1.4rc5-8)"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$NEOTERM_PREFIX/share/man
"
