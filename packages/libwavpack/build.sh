NEOTERM_PKG_HOMEPAGE=https://www.wavpack.com/
NEOTERM_PKG_DESCRIPTION="A completely open audio compression format providing lossless, high-quality lossy, and a unique hybrid compression mode"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.6.0
NEOTERM_PKG_SRCURL=https://github.com/dbry/WavPack/releases/download/${NEOTERM_PKG_VERSION}/wavpack-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=af8035f457509c3d338b895875228a9b81de276c88c79bb2d3e31d9b605da9a9
NEOTERM_PKG_DEPENDS="libandroid-glob"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
