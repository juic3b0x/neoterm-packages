NEOTERM_PKG_HOMEPAGE=https://github.com/nlohmann/json
NEOTERM_PKG_DESCRIPTION="JSON for Modern C++"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE.MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.11.3"
NEOTERM_PKG_SRCURL=https://github.com/nlohmann/json/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0d8ef5af7f9794e3263480193c491549b2ba6cc74bb018906202ada498a79406
NEOTERM_PKG_AUTO_UPDATE=true
# Avoid tests, otherwise we run into the same/similar issue as in
# https://github.com/neoterm/neoterm-packages/issues/1149
# /home/builder/.neoterm-build/_cache/android-r23b-api-24-v6/bin/clang++ --target=aarch64-none-linux-android --gcc-toolchain=/home/builder/.neoterm-build/_cache/android-r23b-api-24-v6 --sysroot=/home/builder/.neoterm-build/_cache/android-r23b-api-24-v6/sysroot  -I/home/builder/.neoterm-build/nlohmann-json/src/test/thirdparty/doctest -fstack-protector-strong -Oz --target=aarch64-linux-android24  -I/data/data/io.neoterm/files/usr/include -O3 -DNDEBUG -fPIC -MD -MT test/CMakeFiles/doctest_main.dir/src/unit.cpp.o -MF test/CMakeFiles/doctest_main.dir/src/unit.cpp.o.d -o test/CMakeFiles/doctest_main.dir/src/unit.cpp.o -c /home/builder/.neoterm-build/nlohmann-json/src/test/src/unit.cpp
# In file included from /home/builder/.neoterm-build/nlohmann-json/src/test/src/unit.cpp:31:
# In file included from /home/builder/.neoterm-build/nlohmann-json/src/test/thirdparty/doctest/doctest_compatibility.h:6:
# In file included from /home/builder/.neoterm-build/nlohmann-json/src/test/thirdparty/doctest/doctest.h:2806:
# /home/builder/.neoterm-build/_cache/android-r23b-api-24-v6/sysroot/usr/include/c++/v1/cmath:317:9: error: no member named 'signbit' in the global namespace; did you mean 'sigwait'?
# using ::signbit;
#       ~~^
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DJSON_BuildTests=off"
