NEOTERM_PKG_HOMEPAGE=https://w3m.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Text based Web browser and pager"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=0.5.3
_MINOR_VERSION=20230121
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.${_MINOR_VERSION}
# The upstream w3m project is dead, but every linux distribution uses
# this maintained fork in debian:
NEOTERM_PKG_SRCURL=https://github.com/tats/w3m/archive/v${_MAJOR_VERSION}+git${_MINOR_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fdc7d55d3c0104db26aa9759db34f37e5eee03f44c868796e3bbfb8935c96e39
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="libgc, ncurses, openssl, zlib"
NEOTERM_PKG_RECOMMENDS="libsixel"
NEOTERM_PKG_SUGGESTS="perl"

# ac_cv_func_bcopy=yes to avoid w3m defining it's own bcopy function, which
# breaks 64-bit builds where NDK headers define bcopy as a macro:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setpgrp_void=yes ac_cv_func_bcopy=yes"

#Overwrite the default /usr/bin/firefox with neoterm-open-url as default external browser. That way, pressing "M" on a URL will open a link in Androids default Browser.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --with-browser=neoterm-open-url"
#Overwrite the default editor to just vi, as the default was /usr/bin/vi.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --with-editor=nano"
# Build w3mimg with X11/imlib2.
# w3mimgdisplay is in w3m-img subpackage.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-image=x11 --with-imagelib=imlib2"

# For Makefile.in.patch:
export NEOTERM_PKG_BUILDER_DIR
