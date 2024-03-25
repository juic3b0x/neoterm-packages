NEOTERM_PKG_HOMEPAGE=https://www.gpsbabel.org/
NEOTERM_PKG_DESCRIPTION="GPS file conversion plus transfer to/from GPS units"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# 1.4.4 is the last version that does not require Qt dependency.
NEOTERM_PKG_VERSION=1.4.4
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/gpsbabel/gpsbabel/archive/gpsbabel_${NEOTERM_PKG_VERSION//./_}.tar.gz
NEOTERM_PKG_SHA256=22860e913f093aa9124e295d52d1d4ae1afccaa67ed6bed6f1f8d8b0a45336d1
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libexpat"

neoterm_step_post_get_source() {
	NEOTERM_PKG_SRCDIR+=/gpsbabel
}
