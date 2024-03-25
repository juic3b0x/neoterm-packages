NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/aa-project/
NEOTERM_PKG_DESCRIPTION="A portable ASCII art graphic library"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.4rc5
NEOTERM_PKG_REVISION=11
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/aa-project/aalib-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=fbddda9230cf6ee2a4f5706b4b11e2190ae45f5eda1f0409dc4f99b35e0a70ee
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--infodir=$NEOTERM_PREFIX/share/info
--mandir=$NEOTERM_PREFIX/share/man
"

neoterm_step_pre_configure() {
	local _bin=$NEOTERM_PKG_BUILDDIR/_wrapper/bin
	mkdir -p $_bin
	local _cc=$(basename $CC)
	cat <<-EOF > $_bin/$_cc
		#!$(command -v sh)
		_shared=
		for f in "\$@"; do
			case "\$f" in
				-shared ) _shared=1 ;;
			esac
		done
		exec "$(command -v $_cc)" "\$@" \${_shared:+-Wl,-rpath=$NEOTERM_PREFIX/lib}
	EOF
	chmod 0700 $_bin/$_cc
	export PATH=$_bin:$PATH
}
