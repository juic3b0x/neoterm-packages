NEOTERM_PKG_HOMEPAGE=https://homepages.laas.fr/mallet/soft/shell/eltclsh
NEOTERM_PKG_DESCRIPTION="Interactive shell for TCL programming language"
## per https://directory.fsf.org/wiki/Eltclsh and their ports http://robotpkg.openrobots.org/robotpkg/shell/eltclsh/ and embedded license headers in init.tcl
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@flosnvjx"
NEOTERM_PKG_VERSION="1.19"
NEOTERM_PKG_SRCURL=https://www.openrobots.org/distfiles/eltclsh/eltclsh-"$NEOTERM_PKG_VERSION".tar.gz
NEOTERM_PKG_SHA256=d4e4f7b79d89a5ed37dc7535d00ac3894fcf3ba33245e672d7a0753ede39d351
NEOTERM_PKG_DEPENDS="tcl, libedit"
NEOTERM_PKG_BUILD_DEPENDS="tk"
NEOTERM_PKG_SUGGESTS="tk"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME
	sed -ne '/Copyright/,/ADVISED OF THE POSSIBILITY OF SUCH DAMAGE./s%^# %%p' $NEOTERM_PKG_SRCDIR/tcl/init.tcl > $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/LICENSE
}
