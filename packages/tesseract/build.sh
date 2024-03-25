NEOTERM_PKG_HOMEPAGE=https://github.com/tesseract-ocr/tesseract
NEOTERM_PKG_DESCRIPTION="Tesseract is probably the most accurate open source OCR engine available"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.3.4"
NEOTERM_PKG_SRCURL=https://github.com/tesseract-ocr/tesseract/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=141afc12b34a14bb691a939b4b122db0d51bd38feda7f41696822bacea7710c7
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="fontconfig, glib, harfbuzz, leptonica, libandroid-glob, libandroid-posix-semaphore, libarchive, libc++, libcairo, libcurl, libicu, pango"
NEOTERM_PKG_BUILD_DEPENDS="libcpufeatures"
NEOTERM_PKG_BREAKS="tesseract-dev"
NEOTERM_PKG_REPLACES="tesseract-dev"
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DUSE_SYSTEM_ICU=on
-DTESSDATA_PREFIX=$NEOTERM_PREFIX/share
-DOPENMP_BUILD=ON
-DLEPT_TIFF_RESULT=0
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=5

	local v=$(sed -n 's/^\([^.]*\)\..*/\1/p' VERSION)
	if [ "${_SOVERSION}" != "${v}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-posix-semaphore"
}

neoterm_step_post_make_install() {
	# download english trained data
	mkdir -p "${NEOTERM_PREFIX}"/share/tessdata
	cd "${NEOTERM_PREFIX}"/share/tessdata
	rm -f eng.*

	local checksums
	declare -A checksums
	checksums[cube.bigrams]=64adf2cc0b2a6705368aa357224d1a6739035d5fe892cd0cc457016df5b4280f
	checksums[cube.fold]=2b229895623934b493fe69c51fcc387295d91af8b4e43cc51748b3d269a95eed
	checksums[cube.lm]=a6f769245b0a55f42a3ce157cd19d96828483c3384c6483433ed83579ea16e36
	checksums[cube.nn]=8f345f1c19772dd71a5214bc94175ccf647c003ab77e4143fde48f11bf3cb0ef
	checksums[cube.params]=c2aa2854951bd823d89cc86d53a6d9712a6a885de6fbaf650ff3df48bfed85d7
	checksums[cube.size]=e5f95de7e2754eb2df03451885277ca4573b3770816043ae2e2f09d1f7232604
	checksums[cube.word-freq]=8d612bef20ae3052fce0b8650575a80d87c94d772ec6d1f0c6a1ad591586ea44
	checksums[tesseract_cube.nn]=196bedc8a5bc8c30361c2c9518f648b45b498759cb6041827ff6fbfb8da2a8d1
	checksums[traineddata]=c0515c9f1e0c79e1069fcc05c2b2f6a6841fb5e1082d695db160333c1154f06d

	mkdir -p $NEOTERM_PKG_CACHEDIR/tessdata

	neoterm_download \
		https://raw.githubusercontent.com/tesseract-ocr/tessdata/4.0.0/eng.traineddata \
		$NEOTERM_PKG_CACHEDIR/tessdata/eng.traineddata \
		daa0c97d651c19fba3b25e81317cd697e9908c8208090c94c3905381c23fc047
	cp $NEOTERM_PKG_CACHEDIR/tessdata/eng.traineddata .
}
