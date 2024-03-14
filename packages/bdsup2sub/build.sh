NEOTERM_PKG_HOMEPAGE=https://github.com/mjuhasz/BDSup2Sub
NEOTERM_PKG_DESCRIPTION="A subtitle conversion tool for image based stream formats"
NEOTERM_PKG_LICENSE="Apache-2.0, LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.0.1
NEOTERM_PKG_SRCURL=https://github.com/mjuhasz/BDSup2Sub/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8ad9529e58d2eeadb5c2be80bfcdaaa06a8714c3144c327491c1d19431993ad9
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="openjdk-17"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	cp -T $NEOTERM_PKG_BUILDER_DIR/src-Manifest.txt src/Manifest.txt
}

neoterm_step_pre_configure() {
	_BUILD_JARFILE="$NEOTERM_PKG_BUILDDIR/${NEOTERM_PKG_NAME}.jar"
}

neoterm_step_make() {
	cd src
	javac -encoding UTF-8 -source 1.8 -target 1.8 $(find . -name "*.java")
	rm -f "${_BUILD_JARFILE}"
	jar cfm "${_BUILD_JARFILE}" Manifest.txt $(find . -name "*.class")
}

neoterm_step_make_install() {
	local _JAR_DIR=$NEOTERM_PREFIX/share/java
	install -Dm600 -t ${_JAR_DIR} "${_BUILD_JARFILE}"

	local exe=$NEOTERM_PREFIX/bin/bdsup2sub
	mkdir -p $(dirname ${exe})
	rm -f ${exe}
	cat <<-EOF > ${exe}
		#!$NEOTERM_PREFIX/bin/sh
		exec java -jar ${_JAR_DIR}/$(basename "${_BUILD_JARFILE}") "\$@"
	EOF
	chmod 0700 ${exe}
}
