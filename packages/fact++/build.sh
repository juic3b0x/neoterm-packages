NEOTERM_PKG_HOMEPAGE=https://bitbucket.org/dtsarkov/factplusplus
NEOTERM_PKG_DESCRIPTION="Re-implementation of the well-known FaCT Description Logic (DL) Reasoner"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_LICENSE_FILE="licensing/FaCT++.license.txt, licensing/lgpl-2.1.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.5
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://bitbucket.org/dtsarkov/factplusplus/downloads/FaCTpp-src-v${NEOTERM_PKG_VERSION}.zip
NEOTERM_PKG_SHA256=d76ce04073ad6523eeb3fc761c012b20e3062ff78406f9da3fd2076828264e4e
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/src"
}
