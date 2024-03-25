NEOTERM_PKG_HOMEPAGE=https://github.com/Tencent/ncnn
NEOTERM_PKG_DESCRIPTION="A high-performance neural network inference framework optimized for the mobile platform"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=4b97730b0d033b4dc2a790e5c35745e0dbf51569
NEOTERM_PKG_VERSION="20230627"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=git+https://github.com/Tencent/ncnn
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_SHA256=a81ee5b6df97830919f8ed8554c99a4f223976ed82eee0cc9f214de0ce53dd2a
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="abseil-cpp, glslang, libc++, vulkan-loader"
NEOTERM_PKG_BUILD_DEPENDS="protobuf-static, python, vulkan-headers, vulkan-loader-android"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel, pybind11"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DNCNN_BUILD_BENCHMARK=OFF
-DNCNN_BUILD_EXAMPLES=OFF
-DNCNN_BUILD_TESTS=OFF
-DNCNN_BUILD_TOOLS=OFF
-DNCNN_DISABLE_EXCEPTION=OFF
-DNCNN_DISABLE_RTTI=OFF
-DNCNN_ENABLE_LTO=ON
-DNCNN_OPENMP=ON
-DNCNN_PYTHON=ON
-DNCNN_SHARED_LIB=OFF
-DNCNN_SIMPLEOCV=ON
-DNCNN_SIMPLEOMP=ON
-DNCNN_SIMPLESTL=OFF
-DNCNN_SYSTEM_GLSLANG=ON
-DNCNN_VULKAN=ON
-DVulkan_LIBRARY=${NEOTERM_PREFIX}/lib/libvulkan.so
-DVulkan_INCLUDE_DIRS=${NEOTERM_PREFIX}/include
"

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout "${_COMMIT}"
	git submodule update --init --recursive --depth=1
	git clean -ffxd

	local version=$(git log -1 --format=%cs | sed -e "s|-||g")
	if [[ "${version}" != "${NEOTERM_PKG_VERSION}" ]]; then
		neoterm_error_exit <<- EOL
		Version mismatch detected!
		build.sh: ${NEOTERM_PKG_VERSION}
		git repo: ${version}
		EOL
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files"
	fi
}

neoterm_step_pre_configure() {
	neoterm_setup_cmake
	neoterm_setup_ninja
	neoterm_setup_protobuf

	CXXFLAGS+=" -std=c++17"
	LDFLAGS+=" $("${NEOTERM_SCRIPTDIR}/packages/libprotobuf/interface_link_libraries.sh")"
	LDFLAGS+=" -lutf8_range -lutf8_validity"
	LDFLAGS+=" -landroid -ljnigraphics -llog"

	mv -v "${NEOTERM_PREFIX}"/lib/libprotobuf.so{,.tmp}
}

neoterm_step_post_make_install() {
	# the build system can only build static or shared
	# at a given time
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
	-DNCNN_BUILD_TOOLS=ON
	-DNCNN_SHARED_LIB=ON
	"
	neoterm_step_configure
	neoterm_step_make
	neoterm_step_make_install

	pushd python
	pip install --no-deps . --prefix "${NEOTERM_PREFIX}"
	popd

	mv -v "${NEOTERM_PREFIX}"/lib/libprotobuf.so{.tmp,}

	return

	# below are testing tools that should not be packaged
	# as they can be >100MB
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
	-DNCNN_BUILD_BENCHMARK=ON
	-DNCNN_BUILD_EXAMPLES=ON
	-DNCNN_BUILD_TESTS=ON
	-DNCNN_SHARED_LIB=OFF
	"
	neoterm_step_configure
	neoterm_step_make

	local tools_dir="${NEOTERM_PREFIX}/lib/ncnn"

	local benchmarks=$(find benchmark -mindepth 1 -maxdepth 1 -type f | sort)
	for benchmark in ${benchmarks}; do
		case "$(basename "${benchmark}")" in
			*[Cc][Mm]ake*) continue ;;
			*.cpp*) continue ;;
			*.md) continue ;;
			*.*) install -v -Dm644 "${benchmark}" -t "${tools_dir}/benchmark" ;;
			*) install -v -Dm755 "${benchmark}" -t "${tools_dir}/benchmark" ;;
		esac
	done

	local examples=$(find examples -mindepth 1 -maxdepth 1 -type f | sort)
	for example in ${examples}; do
		case "$(basename "${example}")" in
			*[Cc][Mm]ake*) continue ;;
			*.cpp*) continue ;;
			*.*) install -v -Dm644 "${example}" -t "${tools_dir}/examples" ;;
			*) install -v -Dm755 "${example}" -t "${tools_dir}/examples" ;;
		esac
	done

	local tests=$(find tests -mindepth 1 -maxdepth 1 -type f | sort)
	for test in ${tests}; do
		case "$(basename "${test}")" in
			*[Cc][Mm]ake*) continue ;;
			*.cpp*) continue ;;
			*.h) continue ;;
			*.py) continue ;;
			*) install -v -Dm755 "${test}" -t "${tools_dir}/tests" ;;
		esac
	done
}

neoterm_step_post_massage() {
	rm -f lib/libprotobuf.so
}
