NEOTERM_PKG_HOMEPAGE=https://github.com/beanshell/beanshell
NEOTERM_PKG_DESCRIPTION="Small, free, embeddable, source level Java interpreter with object based scripting language features written in Java"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.1.1"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/beanshell/beanshell/releases/download/$NEOTERM_PKG_VERSION/bsh-$NEOTERM_PKG_VERSION.jar
NEOTERM_PKG_SHA256=71192cbbe49e7a269cfcba05dc5cb959c33b9b26dafcd6266ca3288b461f86a3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="dash, neoterm-tools"
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_download \
		"$NEOTERM_PKG_SRCURL" \
		"$NEOTERM_PKG_CACHEDIR/bsh-$NEOTERM_PKG_VERSION.jar" \
		"$NEOTERM_PKG_SHA256"
}

neoterm_step_make() {
	$NEOTERM_D8 --output beanshell.jar \
		"$NEOTERM_PKG_CACHEDIR/bsh-$NEOTERM_PKG_VERSION.jar"
}

neoterm_step_make_install() {
	install -Dm600 beanshell.jar "$NEOTERM_PREFIX/share/dex/beanshell.jar"

	{
		echo "#!$NEOTERM_PREFIX/bin/sh"
		echo "dalvikvm -Xcompiler-option --compiler-filter=speed -cp $NEOTERM_PREFIX/share/dex/beanshell.jar bsh.Interpreter \"\$@\""
	} > "$NEOTERM_PREFIX"/bin/beanshell

	chmod 700 "$NEOTERM_PREFIX"/bin/beanshell
	ln -sfr "$NEOTERM_PREFIX"/bin/beanshell "$NEOTERM_PREFIX"/bin/bsh
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${NEOTERM_PREFIX}/bin/bash
  	chmod -w $NEOTERM_PREFIX/share/dex/beanshell.jar
	rm -f $NEOTERM_PREFIX/share/dex/oat/*/beanshell.{art,oat,odex,vdex} >/dev/null 2>&1
	exit 0
	EOF
}
