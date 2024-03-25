NEOTERM_PKG_HOMEPAGE=https://www.mozilla.org/firefox
NEOTERM_PKG_DESCRIPTION="Mozilla Firefox web browser"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="121.0.1"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://ftp.mozilla.org/pub/firefox/releases/${NEOTERM_PKG_VERSION}/source/firefox-${NEOTERM_PKG_VERSION}.source.tar.xz
NEOTERM_PKG_SHA256=b3a4216e01eaeb9a7c6ef4659d8dcd956fbd90a78a8279ee3a598881e63e49ce
# ffmpeg and pulseaudio are dependencies through dlopen(3):
NEOTERM_PKG_DEPENDS="ffmpeg, fontconfig, freetype, gdk-pixbuf, glib, gtk3, libandroid-shmem, libc++, libcairo, libevent, libffi, libice, libicu, libjpeg-turbo, libnspr, libnss, libpixman, libsm, libvpx, libwebp, libx11, libxcb, libxcomposite, libxdamage, libxext, libxfixes, libxrandr, libxtst, pango, pulseaudio, zlib"
NEOTERM_PKG_BUILD_DEPENDS="binutils-cross, libcpufeatures, libice, libsm"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_pkg_auto_update() {
	# https://archive.mozilla.org/pub/firefox/releases/latest/README.txt
	local e=0
	local api_url="https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
	local api_url_r=$(curl -s "${api_url}")
	local latest_version=$(echo "${api_url_r}" | sed -nE "s/.*firefox-(.*).tar.bz2.*/\1/p")
	[[ -z "${api_url_r}" ]] && e=1
	[[ -z "${latest_version}" ]] && e=1

	local uptime_now=$(cat /proc/uptime)
	local uptime_s="${uptime_now//.*}"
	local uptime_h_limit=2
	local uptime_s_limit=$((uptime_h_limit*60*60))
	[[ -z "${uptime_s}" ]] && e=1
	[[ "${uptime_s}" == 0 ]] && e=1
	[[ "${uptime_s}" -gt "${uptime_s_limit}" ]] && e=1

	if [[ "${e}" != 0 ]]; then
		cat <<- EOL >&2
		WARN: Auto update failure!
		api_url_r=${api_url_r}
		latest_version=${latest_version}
		uptime_now=${uptime_now}
		uptime_s=${uptime_s}
		uptime_s_limit=${uptime_s_limit}
		EOL
		return
	fi

	neoterm_pkg_upgrade_version "${latest_version}"
}

neoterm_step_post_get_source() {
	local f="media/ffvpx/config_unix_aarch64.h"
	echo "Applying sed substitution to ${f}"
	sed -E '/^#define (CONFIG_LINUX_PERF|HAVE_SYSCTL) /s/1$/0/' -i ${f}
}

neoterm_step_pre_configure() {
	neoterm_setup_nodejs
	neoterm_setup_rust

	# https://github.com/rust-lang/rust/issues/49853
	# https://github.com/rust-lang/rust/issues/45854
	# Out of memory when building gkrust
	# CI shows (signal: 9, SIGKILL: kill)
	if [ "$NEOTERM_DEBUG_BUILD" = false ]; then
		case "${NEOTERM_ARCH}" in
		aarch64|arm|i686|x86_64) RUSTFLAGS+=" -C debuginfo=1" ;;
		esac
	fi

	cargo install cbindgen

	export HOST_CC=$(command -v clang)
	export HOST_CXX=$(command -v clang++)

	# https://reviews.llvm.org/D141184
	CXXFLAGS+=" -U__ANDROID__ -D_LIBCPP_HAS_NO_C11_ALIGNED_ALLOC"
	LDFLAGS+=" -landroid-shmem -llog"

	if [ "$NEOTERM_ARCH" = "arm" ]; then
		neoterm_setup_no_integrated_as
		# For symbol android_getCpuFeatures
		LDFLAGS+=" -l:libndk_compat.a"
	fi
}

neoterm_step_configure() {
	sed \
		-e "s|@NEOTERM_HOST_PLATFORM@|${NEOTERM_HOST_PLATFORM}|" \
		-e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|" \
		-e "s|@CARGO_TARGET_NAME@|${CARGO_TARGET_NAME}|" \
		$NEOTERM_PKG_BUILDER_DIR/mozconfig.cfg > .mozconfig

	if [ "$NEOTERM_DEBUG_BUILD" = true ]; then
		cat >>.mozconfig - <<END
ac_add_options --enable-debug-symbols
ac_add_options --disable-install-strip
END
	fi

	./mach configure
}

neoterm_step_make() {
	./mach build
	./mach buildsymbols
}

neoterm_step_make_install() {
	./mach install

	install -Dm644 -t "${NEOTERM_PREFIX}/share/applications" "${NEOTERM_PKG_BUILDER_DIR}/firefox.desktop"
}

neoterm_step_post_make_install() {
	# https://github.com/neoterm/neoterm-packages/issues/18429
	# https://phabricator.services.mozilla.com/D181687
	# Android 8.x and older not support "-z pack-relative-relocs" / DT_RELR
	local r=$("${READELF}" -d "${NEOTERM_PREFIX}/bin/firefox")
	if [[ -n "$(echo "${r}" | grep "(RELR)")" ]]; then
		neoterm_error_exit "DT_RELR is unsupported on Android 8.x and older\n${r}"
	fi
}
