NEOTERM_PKG_HOMEPAGE=https://steghide.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Embeds a message in a file by replacing some of the least significant bits"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.5.1
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_SRCURL=http://downloads.sourceforge.net/steghide/steghide-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=78069b7cfe9d1f5348ae43f918f06f91d783c2b3ff25af021e6a312cf541b47b
NEOTERM_PKG_DEPENDS="libc++, libjpeg-turbo, libmcrypt, libmhash, zlib"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_file__dev_random=yes
ac_cv_file__dev_urandom=yes
--mandir=$NEOTERM_PREFIX/share/man
"
