NEOTERM_PKG_HOMEPAGE=https://github.com/neoterm/neoterm-x11
NEOTERM_PKG_DESCRIPTION="Termux X11 add-on application. Still in early development."
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Twaik Yont @twaik"
NEOTERM_PKG_VERSION=1.03.00
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/neoterm/neoterm-x11/archive/a50f18ef2d148a299387435edbde8fe690e9c504.tar.gz
NEOTERM_PKG_SHA256=040ac1d57f610263d374b105ee7c5cd20099f98e3d8e43cb9bd203b803a93684
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="xkeyboard-config"
NEOTERM_PKG_BREAKS="neoterm-x11"
NEOTERM_PKG_REPLACES="neoterm-x11"
_JDK_VERSION=17.0.7.7.1
_GRADLE_VERSION=8.1.1

neoterm_step_make() {
	# Download and use a new enough gradle version to avoid the process hanging after running:
	neoterm_download \
		https://corretto.aws/downloads/resources/$_JDK_VERSION/amazon-corretto-$_JDK_VERSION-linux-x64.tar.gz \
		$NEOTERM_PKG_CACHEDIR/amazon-corretto-$_JDK_VERSION-linux-x64.tar.gz \
		8d23e0f1249f2852caa76b7ae8770847e005e4310a70a46b7c1a816c34ff9195
	neoterm_download \
		https://services.gradle.org/distributions/gradle-$_GRADLE_VERSION-all.zip \
		$NEOTERM_PKG_CACHEDIR/gradle-$_GRADLE_VERSION-all.zip \
		5625a0ae20fe000d9225d000b36909c7a0e0e8dda61c19b12da769add847c975
	mkdir $NEOTERM_PKG_TMPDIR/gradle
	mkdir $NEOTERM_PKG_TMPDIR/gradle-jdk
	
	tar --strip-components=1 -xf $NEOTERM_PKG_CACHEDIR/amazon-corretto-$_JDK_VERSION-linux-x64.tar.gz -C $NEOTERM_PKG_TMPDIR/gradle-jdk
	unzip -q $NEOTERM_PKG_CACHEDIR/gradle-$_GRADLE_VERSION-all.zip -d $NEOTERM_PKG_TMPDIR/gradle

	# Avoid spawning the gradle daemon due to org.gradle.jvmargs
	# being set (https://github.com/gradle/gradle/issues/1434):
	rm gradle.properties

	export JAVA_HOME="$NEOTERM_PKG_TMPDIR/gradle-jdk"
	export ANDROID_HOME
	export GRADLE_OPTS="-Dorg.gradle.daemon=false -Xmx1536m"
	
	echo "org.gradle.jvmargs=-Xmx1536m" > $NEOTERM_PKG_SRCDIR/gradle.properties
	echo "android.useAndroidX=true" >> $NEOTERM_PKG_SRCDIR/gradle.properties
	echo "android.enableJetifier=true" >> $NEOTERM_PKG_SRCDIR/gradle.properties

	cd $NEOTERM_PKG_SRCDIR
	# Github action builds are signed with debug key, and loader checks self signature while loading main package.
	$NEOTERM_PKG_TMPDIR/gradle/gradle-$_GRADLE_VERSION/bin/gradle :shell-loader:assembleDebug
}

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/bin
	mkdir -p $NEOTERM_PREFIX/libexec/neoterm-x11
	cp $NEOTERM_PKG_SRCDIR/neoterm-x11 $NEOTERM_PREFIX/bin/neoterm-x11
	cp $NEOTERM_PKG_SRCDIR/shell-loader/build/outputs/apk/debug/shell-loader-debug.apk \
		$NEOTERM_PREFIX/libexec/neoterm-x11/loader.apk
}

neoterm_step_create_debscripts() {
	cat <<- EOF > postinst
		#!${NEOTERM_PREFIX}/bin/sh
		chmod -w $NEOTERM_PREFIX/libexec/neoterm-x11/loader.apk
	EOF
}
