NEOTERM_PKG_HOMEPAGE=http://developer.android.com/tools/help/index.html
NEOTERM_PKG_DESCRIPTION="Command which takes in Java class files and converts them to format executable by Dalvik VM"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:1.16
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_SRCURL=https://github.com/juic3b0x/distfiles/releases/download/2021.01.04/dx-android-${NEOTERM_PKG_VERSION:2}.jar
NEOTERM_PKG_SHA256=b9b7917267876b74c8ff6707e7a576c93b6dfe8cacc4f1cc791d606bcbbb7bd5
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	neoterm_download "$NEOTERM_PKG_SRCURL" \
		"$NEOTERM_PKG_CACHEDIR/dx-${NEOTERM_PKG_VERSION:2}.jar" \
		"$NEOTERM_PKG_SHA256"

	install -Dm600 "$NEOTERM_PKG_CACHEDIR/dx-${NEOTERM_PKG_VERSION:2}.jar" \
		"$NEOTERM_PREFIX"/share/dex/dx.jar

	cat <<- EOF > "$NEOTERM_PREFIX"/bin/dx
	#!${NEOTERM_PREFIX}/bin/sh
	exec dalvikvm \
		-Xcompiler-option --compiler-filter=speed \
		-Xmx256m \
		-cp ${NEOTERM_PREFIX}/share/dex/dx.jar \
		dx.dx.command.Main "\$@"
	EOF
	chmod 700 "$NEOTERM_PREFIX"/bin/dx

	cat <<- EOF > "$NEOTERM_PREFIX"/bin/dx-merge
	#!${NEOTERM_PREFIX}/bin/sh
	exec dalvikvm \
		-Xcompiler-option --compiler-filter=speed \
		-Xmx256m \
		-cp ${NEOTERM_PREFIX}/share/dex/dx.jar \
		dx.dx.merge.DexMerger "\$@"
	EOF
	chmod 700 "$NEOTERM_PREFIX"/bin/dx-merge
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${NEOTERM_PREFIX}/bin/bash
	rm -f $NEOTERM_PREFIX/share/dex/oat/*/dx.{art,oat,odex,vdex} >/dev/null 2>&1
 	chmod -w $NEOTERM_PREFIX/share/dex/dx.jar
	exit 0
	EOF
}
