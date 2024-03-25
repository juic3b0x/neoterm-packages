NEOTERM_PKG_HOMEPAGE=https://streamripper.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Records and splits streaming mp3 into tracks"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.64.6
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/streamripper/streamripper-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=c1d75f2e9c7b38fd4695be66eff4533395248132f3cc61f375196403c4d8de42
NEOTERM_PKG_DEPENDS="glib, libmad, libogg, libvorbis"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_pthread_pthread_create=yes"
