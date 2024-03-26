#!/bin/bash

set -e -u

: "${NEOTERM_PKG_TMPDIR:="/tmp"}"

# Install desired parts of the Android SDK:
. $(cd "$(dirname "$0")"; pwd)/properties.sh
. $(cd "$(dirname "$0")"; pwd)/build/neoterm_download.sh

ANDROID_SDK_FILE=commandlinetools-linux-${NEOTERM_SDK_REVISION}_latest.zip
ANDROID_SDK_SHA256=2d2d50857e4eb553af5a6dc3ad507a17adf43d115264b1afc116f95c92e5e258
if [ "$NEOTERM_NDK_VERSION" = "26c" ]; then
	ANDROID_NDK_FILE=android-ndk-r${NEOTERM_NDK_VERSION}-linux.zip
	ANDROID_NDK_SHA256=6d6e659834d28bb24ba7ae66148ad05115ebbad7dabed1af9b3265674774fcf6
elif [ "$NEOTERM_NDK_VERSION" = 23c ]; then
	ANDROID_NDK_FILE=android-ndk-r${NEOTERM_NDK_VERSION}-linux.zip
	ANDROID_NDK_SHA256=6ce94604b77d28113ecd588d425363624a5228d9662450c48d2e4053f8039242
else
	echo "ERROR: unknown NDK version $NEOTERM_NDK_VERSION" >&2
	exit 1
fi

if [ ! -d "$ANDROID_HOME" ]; then
	mkdir -p "$ANDROID_HOME"
	cd "$ANDROID_HOME/.."
	rm -Rf "$(basename "$ANDROID_HOME")"

	# https://developer.android.com/studio/index.html#command-tools
	echo "Downloading Android SDK..."
	neoterm_download https://dl.google.com/android/repository/${ANDROID_SDK_FILE} \
		tools-$NEOTERM_SDK_REVISION.zip \
		$ANDROID_SDK_SHA256
	rm -Rf android-sdk-$NEOTERM_SDK_REVISION
	unzip -q tools-$NEOTERM_SDK_REVISION.zip -d android-sdk-$NEOTERM_SDK_REVISION
fi

if [ ! -d "$NDK" ]; then
	mkdir -p "$NDK"
	cd "$NDK/.."
	rm -Rf "$(basename "$NDK")"

	# https://developer.android.com/ndk/downloads
	echo "Downloading Android NDK..."
	neoterm_download https://dl.google.com/android/repository/${ANDROID_NDK_FILE} \
		ndk-r${NEOTERM_NDK_VERSION}.zip \
		$ANDROID_NDK_SHA256
	rm -Rf android-ndk-r$NEOTERM_NDK_VERSION
	unzip -q ndk-r${NEOTERM_NDK_VERSION}.zip

	# Remove unused parts
	rm -Rf android-ndk-r$NEOTERM_NDK_VERSION/sources/cxx-stl/system
fi

if [ -x "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" ]; then
	SDK_MANAGER="$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager"
elif [ -x "$ANDROID_HOME/cmdline-tools/bin/sdkmanager" ]; then
	SDK_MANAGER="$ANDROID_HOME/cmdline-tools/bin/sdkmanager"
else
	echo "ERROR: no usable sdkmanager found in $ANDROID_HOME" >&2
	echo "Checking other possible paths: (empty if not found)" >&2
	find "$ANDROID_HOME" -type f -name sdkmanager >&2
	exit 1
fi

echo "INFO: Using sdkmanager ... $SDK_MANAGER"
echo "INFO: Using NDK ... $NDK"

yes | $SDK_MANAGER --sdk_root="$ANDROID_HOME" --licenses

# The android platforms are used in the ecj and apksigner packages:
yes | $SDK_MANAGER --sdk_root="$ANDROID_HOME" \
		"platform-tools" \
		"build-tools;${NEOTERM_ANDROID_BUILD_TOOLS_VERSION}" \
		"platforms;android-33" \
		"platforms;android-28" \
		"platforms;android-24"
