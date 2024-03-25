NEOTERM_PKG_HOMEPAGE=https://gradle.org/
NEOTERM_PKG_DESCRIPTION="Powerful build system for the JVM"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:8.6"
NEOTERM_PKG_SRCURL=https://services.gradle.org/distributions/gradle-${NEOTERM_PKG_VERSION:2}-bin.zip
NEOTERM_PKG_SHA256=9631d53cf3e74bfa726893aee1f8994fee4e060c401335946dba2156f440f24c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="openjdk-17"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	rm -f ./bin/*.bat
	rm -rf $NEOTERM_PREFIX/opt/gradle
	mkdir -p $NEOTERM_PREFIX/opt/gradle
	cp -r ./* $NEOTERM_PREFIX/opt/gradle/
	for i in $NEOTERM_PREFIX/opt/gradle/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr $i $NEOTERM_PREFIX/bin/$(basename $i)
	done
}

