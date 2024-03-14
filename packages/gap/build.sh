NEOTERM_PKG_HOMEPAGE=https://www.gap-system.org/
NEOTERM_PKG_DESCRIPTION="GAP is a system for computational discrete algebra, with particular emphasis on Computational Group Theory"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.12.2
NEOTERM_PKG_SRCURL=https://github.com/gap-system/gap/releases/download/v${NEOTERM_PKG_VERSION}/gap-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=672308745eb78a222494ee8dd6786edd5bc331456fcc6456ac064bdb28d587a8
NEOTERM_PKG_DEPENDS="readline, libgmp, zlib, gap-packages"
NEOTERM_PKG_BREAKS="gap-dev"
NEOTERM_PKG_REPLACES="gap-dev"
NEOTERM_PKG_GROUPS="science"

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/lib/gap/pkg
	# install at least gapdoc, smallgrp, transgrp, primgrp or else
	# this package is mostly useless.
	cp -r $NEOTERM_PKG_SRCDIR/pkg/gapdoc $NEOTERM_PREFIX/lib/gap/pkg/
	cp -r $NEOTERM_PKG_SRCDIR/pkg/smallgrp $NEOTERM_PREFIX/lib/gap/pkg/
	cp -r $NEOTERM_PKG_SRCDIR/pkg/transgrp $NEOTERM_PREFIX/lib/gap/pkg/
	cp -r $NEOTERM_PKG_SRCDIR/pkg/primgrp $NEOTERM_PREFIX/lib/gap/pkg/

	# To save some disk space, compress transgrp data in place
	# (GAP transparently allows read access to those)
	gzip -9 -n -f $NEOTERM_PREFIX/lib/gap/pkg/transgrp/data/*.*
}
