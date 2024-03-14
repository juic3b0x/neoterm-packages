NEOTERM_PKG_HOMEPAGE=http://docopt.org
NEOTERM_PKG_DESCRIPTION="Command line arguments parser for C++11 and later"
NEOTERM_PKG_LICENSE="BSL-1.0, MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE-Boost-1.0, LICENSE-MIT"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION=0.6.3
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/docopt/docopt.cpp/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=28af5a0c482c6d508d22b14d588a3b0bd9ff97135f99c2814a5aa3cbff1d6632
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
