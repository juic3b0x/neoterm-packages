NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/NeoTermAm
NEOTERM_PKG_DESCRIPTION="Android Oreo-compatible am command reimplementation"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="Michal Bednarski @michalbednarski"
NEOTERM_PKG_VERSION=0.8.0
NEOTERM_PKG_SRCURL=https://github.com/juic3b0x/NeoTermAm/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=969f42e896097c3b637eeb4f0fac92e2a714279fe4d14d10db27832e6be132ad
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_CONFLICTS="neoterm-tools (<< 0.51)"
_GRADLE_VERSION=7.5

neoterm_step_post_get_source() {
	sed -i'' -E -e "s|\@NEOTERM_PREFIX\@|${NEOTERM_PREFIX}|g" "$NEOTERM_PKG_SRCDIR/am-libexec-packaged"
	sed -i'' -E -e "s|\@NEOTERM_APP_PACKAGE\@|${NEOTERM_APP_PACKAGE}|g" "$NEOTERM_PKG_SRCDIR/app/src/main/java/io/neoterm/neotermam/FakeContext.java"
}

neoterm_step_make() {
	# Download and use a new enough gradle version to avoid the process hanging after running:
	neoterm_download \
		https://services.gradle.org/distributions/gradle-$_GRADLE_VERSION-bin.zip \
		$NEOTERM_PKG_CACHEDIR/gradle-$_GRADLE_VERSION-bin.zip \
		cb87f222c5585bd46838ad4db78463a5c5f3d336e5e2b98dc7c0c586527351c2
	mkdir $NEOTERM_PKG_TMPDIR/gradle
	unzip -q $NEOTERM_PKG_CACHEDIR/gradle-$_GRADLE_VERSION-bin.zip -d $NEOTERM_PKG_TMPDIR/gradle

	# Avoid spawning the gradle daemon due to org.gradle.jvmargs
	# being set (https://github.com/gradle/gradle/issues/1434):
  	sed -i'' -E '/^org\.gradle\.jvmargs=.*/d' gradle.properties

	export ANDROID_HOME
	export GRADLE_OPTS="-Dorg.gradle.daemon=false -Xmx1536m -Dorg.gradle.java.home=/usr/lib/jvm/java-1.17.0-openjdk-amd64"

	$NEOTERM_PKG_TMPDIR/gradle/gradle-$_GRADLE_VERSION/bin/gradle \
		:app:assembleRelease
}

neoterm_step_make_install() {
	cp $NEOTERM_PKG_SRCDIR/am-libexec-packaged $NEOTERM_PREFIX/bin/am
	mkdir -p $NEOTERM_PREFIX/libexec/neoterm-am
	cp $NEOTERM_PKG_SRCDIR/app/build/outputs/apk/release/app-release-unsigned.apk $NEOTERM_PREFIX/libexec/neoterm-am/am.apk
}
