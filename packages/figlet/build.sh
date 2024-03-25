NEOTERM_PKG_HOMEPAGE=http://www.figlet.org/
NEOTERM_PKG_DESCRIPTION="Program for making large letters out of ordinary text"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.2.5
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=ftp://ftp.figlet.org/pub/figlet/program/unix/figlet-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bf88c40fd0f077dab2712f54f8d39ac952e4e9f2e1882f1195be9e5e4257417d
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LD=$CC
}
