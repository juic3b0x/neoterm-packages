NEOTERM_PKG_HOMEPAGE=https://dart.dev/
NEOTERM_PKG_DESCRIPTION="Dart is a general-purpose programming language"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_LICENSE_FILE="sdk/LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.3.1
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_SKIP_SRC_EXTRACT=true

# Dart uses tar and gzip to extract downloaded packages.
# Busybox-based versions of such utilities cause issues so
# complete ones should be used.
NEOTERM_PKG_DEPENDS="gzip, tar"

neoterm_step_get_source() {
	mkdir -p $NEOTERM_PKG_SRCDIR
	cd $NEOTERM_PKG_SRCDIR

	git clone --depth=1 https://chromium.googlesource.com/chromium/tools/depot_tools.git
	mkdir -p depot_tools/fakebin
	ln -sfr /usr/bin/python depot_tools/fakebin/python
	export PATH="$(pwd)/depot_tools/fakebin:$(pwd)/depot_tools:${PATH}"

	fetch dart

	cd sdk
	git checkout $NEOTERM_PKG_VERSION
	cd ../

	echo "target_os = ['android']" >> .gclient
	gclient sync -D --force --reset
}

neoterm_step_pre_configure() {
	sed -i -e 's:\([^A-Za-z0-9_]\)/usr/bin:\1'$NEOTERM_PREFIX'/local/bin:g' \
		-e 's:\([^A-Za-z0-9_]\)/bin:\1'$NEOTERM_PREFIX'/bin:g' \
		"$NEOTERM_PKG_SRCDIR/sdk/third_party/pkg/pub/lib/src/io.dart"
}

neoterm_step_make() {
	:
}

neoterm_step_make_install() {
	cd sdk

	rm -f ./out/*/args.gn

	if [ $NEOTERM_ARCH = "arm" ]; then
		python3 ./tools/build.py --no-goma --mode release --arch=arm --os=android create_sdk
		chmod +x ./out/ReleaseAndroidARM/dart-sdk/bin/*
		cp -r ./out/ReleaseAndroidARM/dart-sdk ${NEOTERM_PREFIX}/lib
	elif [ $NEOTERM_ARCH = "i686" ]; then
		python3 ./tools/build.py --no-goma --mode release --arch=ia32 --os=android create_sdk
		chmod +x ./out/ReleaseAndroidIA32/dart-sdk/bin/*
		cp -r ./out/ReleaseAndroidIA32/dart-sdk ${NEOTERM_PREFIX}/lib
	elif [ $NEOTERM_ARCH = "aarch64" ]; then
		python3 ./tools/build.py --no-goma --mode release --arch=arm64c --os=android create_sdk
		chmod +x ./out/ReleaseAndroidARM64C/dart-sdk/bin/*
		cp -r ./out/ReleaseAndroidARM64C/dart-sdk ${NEOTERM_PREFIX}/lib
	elif [ $NEOTERM_ARCH = "x86_64" ]; then
		python3 ./tools/build.py --no-goma --mode release --arch=x64c --os=android create_sdk
		chmod +x ./out/ReleaseAndroidX64C/dart-sdk/bin/*
		cp -r ./out/ReleaseAndroidX64C/dart-sdk ${NEOTERM_PREFIX}/lib
	else
		neoterm_error_exit "Unsupported arch '$NEOTERM_ARCH'"
	fi

	for file in ${NEOTERM_PREFIX}/lib/dart-sdk/bin/*; do
		if [[ -f "$file" ]]; then
			echo -e "#!${NEOTERM_PREFIX}/bin/sh\nexec $file  \"\$@\"" > ${NEOTERM_PREFIX}/bin/$(basename $file)
			chmod +x ${NEOTERM_PREFIX}/bin/$(basename $file)
		fi
	done
}

neoterm_step_post_make_install() {
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/dart-pub-bin.sh \
		$NEOTERM_PREFIX/etc/profile.d/dart-pub-bin.sh
}
