NEOTERM_PKG_HOMEPAGE=https://arj.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Open-source version of arj archiver"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.10.22
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/arj/arj-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=589e4c9bccc8669e7b6d8d6fcd64e01f6a2c21fe10aad56a83304ecc3b96a7db
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	(cd ./gnu && autoconf -f -i)

	# Hack for executing configure script in
	# non-standard directory.
	{
		echo "#!/bin/sh"
		echo "cd ./gnu"
		echo "\$(dirname \$0)/gnu/configure \"\$@\""
	} > ./configure
	chmod +x ./configure
}

# ARJ appends archive of its help to its end. Unfortunately stripping and
# ELF cleaning remove it. So redo this addition and correct the
# ARJ self-checksum.
neoterm_step_post_massage() {
	local build_subdir

	if [ "$NEOTERM_ARCH" = "arm" ]; then
		build_subdir="linux-androideabi"
	else
		build_subdir="linux-android"
	fi

	"$NEOTERM_PKG_SRCDIR/$build_subdir"/en/rs/tools/join \
		bin/arj \
		"$NEOTERM_PKG_SRCDIR/$build_subdir"/en/rs/help.arj
	"$NEOTERM_PKG_SRCDIR/$build_subdir"/en/rs/tools/postproc \
		bin/arj
}
