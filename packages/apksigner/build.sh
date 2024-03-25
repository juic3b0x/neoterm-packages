NEOTERM_PKG_HOMEPAGE=https://developer.android.com/studio/command-line/apksigner
NEOTERM_PKG_DESCRIPTION="APK signing tool from Android SDK"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Do not use the NEOTERM_ANDROID_BUILD_TOOLS_VERSION variable when specifying:
NEOTERM_PKG_VERSION=33.0.1
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="openjdk-17"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true

neoterm_step_pre_configure() {
	# Version guard
	if [ "${NEOTERM_PKG_VERSION#*:}" != "${NEOTERM_ANDROID_BUILD_TOOLS_VERSION}" ]; then
		neoterm_error_exit "Version mismatch between NEOTERM_PKG_VERSION and NEOTERM_ANDROID_BUILD_TOOLS_VERSION."
	fi
}

neoterm_step_make_install() {
	install -Dm600 $ANDROID_HOME/build-tools/${NEOTERM_ANDROID_BUILD_TOOLS_VERSION}/lib/apksigner.jar \
		$NEOTERM_PREFIX/share/java/apksigner.jar
	cat <<- EOF > $NEOTERM_PREFIX/bin/apksigner
	#!${NEOTERM_PREFIX}/bin/sh
	exec java -jar $NEOTERM_PREFIX/share/java/apksigner.jar "\$@"
	EOF
	chmod 700 $NEOTERM_PREFIX/bin/apksigner
}
