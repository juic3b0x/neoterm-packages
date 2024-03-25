NEOTERM_PKG_HOMEPAGE=https://www.eclipse.org/jdt/core/
NEOTERM_PKG_DESCRIPTION="Eclipse Compiler for Java"
NEOTERM_PKG_LICENSE="EPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Version 4.12 is the last known to work on Android 7-8.
_VERSION=4.12
_DATE=201906051800
NEOTERM_PKG_VERSION=1:${_VERSION}
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://archive.eclipse.org/eclipse/downloads/drops${_VERSION:0:1}/R-${_VERSION}-${_DATE}/ecj-${_VERSION}.jar
NEOTERM_PKG_SHA256=69dad18a1fcacd342a7d44c5abf74f50e7529975553a24c64bce0b29b86af497
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_CONFLICTS="ecj4.6"

RAW_JAR=$NEOTERM_PKG_CACHEDIR/ecj-${_VERSION}.jar

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi
}

neoterm_step_get_source() {
	mkdir -p $NEOTERM_PKG_SRCDIR
	neoterm_download $NEOTERM_PKG_SRCURL \
		$RAW_JAR \
		$NEOTERM_PKG_SHA256
}

neoterm_step_make() {
	mkdir -p $NEOTERM_PREFIX/share/{dex,java}
	$NEOTERM_D8 \
		--classpath $ANDROID_HOME/platforms/android-$NEOTERM_PKG_API_LEVEL/android.jar \
		--release \
		--min-api $NEOTERM_PKG_API_LEVEL \
		--output $NEOTERM_PKG_TMPDIR \
		$RAW_JAR

	# Package classes.dex into jar:
	cd $NEOTERM_PKG_TMPDIR
	jar cf ecj.jar classes.dex
	# Add needed properties file to jar file:
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/batch/messages.properties
	jar uf ecj.jar	org/eclipse/jdt/internal/compiler/batch/messages.properties
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/problem/messages.properties
	jar uf ecj.jar	org/eclipse/jdt/internal/compiler/problem/messages.properties
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/messages.properties
	jar uf ecj.jar	org/eclipse/jdt/internal/compiler/messages.properties
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/parser/readableNames.props
	jar uf ecj.jar	org/eclipse/jdt/internal/compiler/parser/readableNames.props
	for i in $(seq 1 24); do
		jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/parser/parser$i.rsc
		jar uf ecj.jar	org/eclipse/jdt/internal/compiler/parser/parser$i.rsc
	done
	# Move into place:
	mv ecj.jar $NEOTERM_PREFIX/share/dex/ecj.jar

	rm -rf android-jar
	mkdir android-jar
	cd android-jar

	# We need the android classes for JDT to compile against.
	cp $ANDROID_HOME/platforms/android-28/android.jar .
	unzip -q android.jar
	rm -Rf android.jar resources.arsc res assets
	jar cfM android.jar .

	cp $NEOTERM_PKG_TMPDIR/android-jar/android.jar $NEOTERM_PREFIX/share/java/android.jar

	# Bundle in an android.jar from an older API also, for those who want to
	# build apps that run on older Android versions.
	rm -Rf ./*
	cp $ANDROID_HOME/platforms/android-$NEOTERM_PKG_API_LEVEL/android.jar android.jar
	unzip -q android.jar
	rm -Rf android.jar resources.arsc res assets
	jar cfM android-$NEOTERM_PKG_API_LEVEL.jar .
	cp $NEOTERM_PKG_TMPDIR/android-jar/android-$NEOTERM_PKG_API_LEVEL.jar $NEOTERM_PREFIX/share/java/

	rm -Rf $NEOTERM_PREFIX/bin/javac
	install $NEOTERM_PKG_BUILDER_DIR/ecj $NEOTERM_PREFIX/bin/ecj
	perl -p -i -e "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" $NEOTERM_PREFIX/bin/ecj
	install $NEOTERM_PKG_BUILDER_DIR/ecj-$NEOTERM_PKG_API_LEVEL $NEOTERM_PREFIX/bin/ecj-$NEOTERM_PKG_API_LEVEL
	perl -p -i -e "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" $NEOTERM_PREFIX/bin/ecj-$NEOTERM_PKG_API_LEVEL
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${NEOTERM_PREFIX}/bin/bash
	chmod -w $NEOTERM_PREFIX/share/dex/ecj.jar
	rm -f $NEOTERM_PREFIX/share/dex/oat/*/ecj.{art,oat,odex,vdex} >/dev/null 2>&1
	exit 0
	EOF
}
