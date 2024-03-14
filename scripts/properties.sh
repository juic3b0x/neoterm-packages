# XXX: This file is sourced by repology-updater script
# So avoid doing things like executing commands except of those available in
# coreutils and are clearly not a default part of most Linux installations,
# or sourcing any other script in our build directories.

NEOTERM_SDK_REVISION=9123335
NEOTERM_ANDROID_BUILD_TOOLS_VERSION=33.0.1
# when changing the above:
# change NEOTERM_PKG_VERSION (and remove NEOTERM_PKG_REVISION if necessary) in:
#   apksigner, d8
# and trigger rebuild of them
: "${NEOTERM_NDK_VERSION_NUM:="26"}"
: "${NEOTERM_NDK_REVISION:="b"}"
NEOTERM_NDK_VERSION=$NEOTERM_NDK_VERSION_NUM$NEOTERM_NDK_REVISION
# when changing the above:
# update version and hashsum in packages
#   libandroid-stub, libc++, ndk-multilib, ndk-sysroot, vulkan-loader-android
# and update SHA256 sums in scripts/setup-android-sdk.sh
# check all packages build and run correctly and bump if needed

: "${NEOTERM_JAVA_HOME:=/usr/lib/jvm/java-17-openjdk-amd64}"
export JAVA_HOME=${NEOTERM_JAVA_HOME}

if [ "${NEOTERM_PACKAGES_OFFLINE-false}" = "true" ]; then
	export ANDROID_HOME=${NEOTERM_SCRIPTDIR}/build-tools/android-sdk-$NEOTERM_SDK_REVISION
	export NDK=${NEOTERM_SCRIPTDIR}/build-tools/android-ndk-r${NEOTERM_NDK_VERSION}
else
	: "${ANDROID_HOME:="${HOME}/lib/android-sdk-$NEOTERM_SDK_REVISION"}"
	: "${NDK:="${HOME}/lib/android-ndk-r${NEOTERM_NDK_VERSION}"}"
fi

# Termux packages configuration.
NEOTERM_APP_PACKAGE="com.neoterm"
NEOTERM_BASE_DIR="/data/data/${NEOTERM_APP_PACKAGE}/files"
NEOTERM_CACHE_DIR="/data/data/${NEOTERM_APP_PACKAGE}/cache"
NEOTERM_ANDROID_HOME="${NEOTERM_BASE_DIR}/home"
NEOTERM_APPS_DIR="${NEOTERM_BASE_DIR}/apps"
NEOTERM_PREFIX_CLASSICAL="${NEOTERM_BASE_DIR}/usr"
NEOTERM_PREFIX="${NEOTERM_PREFIX_CLASSICAL}"

# Path to CGCT tools
export CGCT_DIR="/data/data/${NEOTERM_APP_PACKAGE}/cgct"

# Package name for the packages hosted on the repo.
# This must only equal NEOTERM_APP_PACKAGE if using custom repo that
# has packages that were built with same package name.
NEOTERM_REPO_PACKAGE="com.neoterm"

# Termux repo urls.
NEOTERM_REPO_URL=()
NEOTERM_REPO_DISTRIBUTION=()
NEOTERM_REPO_COMPONENT=()

for url in $(jq -r 'del(.pkg_format) | .[] | .url' ${NEOTERM_SCRIPTDIR}/repo.json); do
	NEOTERM_REPO_URL+=("$url")
done
for distribution in $(jq -r 'del(.pkg_format) | .[] | .distribution' ${NEOTERM_SCRIPTDIR}/repo.json); do
	NEOTERM_REPO_DISTRIBUTION+=("$distribution")
done
for component in $(jq -r 'del(.pkg_format) | .[] | .component' ${NEOTERM_SCRIPTDIR}/repo.json); do
	NEOTERM_REPO_COMPONENT+=("$component")
done

# Allow to override setup.
for f in "${HOME}/.config/neoterm/neotermrc.sh" "${HOME}/.neoterm/neotermrc.sh" "${HOME}/.neotermrc"; do
	if [ -f "$f" ]; then
		echo "Using builder configuration from '$f'..."
		. "$f"
		break
	fi
done
unset f
