NEOTERM_PKG_HOMEPAGE="https://github.com/RfidResearchGroup/proxmark3"
NEOTERM_PKG_DESCRIPTION="The Swiss Army Knife of RFID Research - RRG/Iceman repo"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Marlin Sööse <marlin.soose@esque.ca>"
NEOTERM_PKG_VERSION="1:4.18218"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/RfidResearchGroup/proxmark3/archive/v${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=535ace3d2395d745aab82b77f7bf83ac08ab9ffb328c07ee2e4ddf340d09536a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libbz2, libc++, readline, liblz4"
NEOTERM_PKG_BUILD_IN_SRC="true"
NEOTERM_PKG_BLACKLISTED_ARCHES="i686, x86_64"

neoterm_step_post_configure() {
        export LDLIBS="-L${NEOTERM_PREFIX}/lib"
        export INCLUDES="-I${NEOTERM_PREFIX}/include"
        NEOTERM_PKG_EXTRA_MAKE_ARGS="client CC=$CC CXX=$CXX LD=$CXX cpu_arch=$NEOTERM_ARCH SKIPREVENGTEST=1 SKIPQT=1 SKIPPTHREAD=1 SKIPGD=1 PLATFORM=PM3GENERIC"
}

neoterm_step_make_install() {
        install -Dm700 "$NEOTERM_PKG_BUILDDIR"/client/proxmark3 "$NEOTERM_PREFIX"/bin/proxmark3
        mkdir -p "$NEOTERM_PREFIX"/share/proxmark3/
        cp -R "$NEOTERM_PKG_BUILDDIR"/client/resources/ "$NEOTERM_PREFIX"/share/proxmark3/resources/
        cp -R "$NEOTERM_PKG_BUILDDIR"/client/dictionaries/ "$NEOTERM_PREFIX"/share/proxmark3/dictionaries/
        cp -R "$NEOTERM_PKG_BUILDDIR"/client/pyscripts/ "$NEOTERM_PREFIX"/share/proxmark3/pyscripts/
        cp -R "$NEOTERM_PKG_BUILDDIR"/client/luascripts/ "$NEOTERM_PREFIX"/share/proxmark3/luascripts/
        cp -R "$NEOTERM_PKG_BUILDDIR"/client/lualibs/ "$NEOTERM_PREFIX"/share/proxmark3/lualibs/
}
