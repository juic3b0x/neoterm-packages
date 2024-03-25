NEOTERM_PKG_HOMEPAGE=https://github.com/svend/cuetools
NEOTERM_PKG_DESCRIPTION="A set of utilities for working with Cue Sheet (cue) and Table of Contents (toc) files"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.4.1
NEOTERM_PKG_SRCURL=https://github.com/svend/cuetools/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=24a2420f100c69a6539a9feeb4130d19532f9f8a0428a8b9b289c6da761eb107
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_pre_configure() {
	autoreconf -fi
}
