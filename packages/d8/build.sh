TERMUX_PKG_HOMEPAGE=https://developer.android.com/studio/command-line/d8
TERMUX_PKG_DESCRIPTION="DEX bytecode compiler from Android SDK"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@neoterm"
# Do not use the TERMUX_ANDROID_BUILD_TOOLS_VERSION variable when specifying:
TERMUX_PKG_VERSION=33.0.1
TERMUX_PKG_AUTO_UPDATE=false
TERMUX_PKG_DEPENDS="openjdk-17"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true

termux_step_pre_configure() {
	# Version guard
	if [ "${TERMUX_PKG_VERSION#*:}" != "${TERMUX_ANDROID_BUILD_TOOLS_VERSION}" ]; then
		termux_error_exit "Version mismatch between TERMUX_PKG_VERSION and TERMUX_ANDROID_BUILD_TOOLS_VERSION."
	fi
}

termux_step_make_install() {
	install -Dm600 $ANDROID_HOME/build-tools/${TERMUX_ANDROID_BUILD_TOOLS_VERSION}/lib/d8.jar \
		$TERMUX_PREFIX/share/java/d8.jar

	cat <<- EOF > $TERMUX_PREFIX/bin/d8
	#!${TERMUX_PREFIX}/bin/sh
	exec java -cp $TERMUX_PREFIX/share/java/d8.jar com.android.tools.r8.D8 "\$@"
	EOF

	cat <<- EOF > $TERMUX_PREFIX/bin/r8
	#!${TERMUX_PREFIX}/bin/sh
	exec java -cp $TERMUX_PREFIX/share/java/d8.jar com.android.tools.r8.R8 "\$@"
	EOF

	chmod 700 $TERMUX_PREFIX/bin/d8 $TERMUX_PREFIX/bin/r8
}
