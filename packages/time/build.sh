NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/time/
NEOTERM_PKG_DESCRIPTION="GNU time program for measuring CPU resource usage"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.9
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/time/time-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=fbacf0c81e62429df3e33bda4cee38756604f18e01d977338e23306a3e3b521e
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_wait3_rusage=yes"
