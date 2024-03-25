NEOTERM_PKG_HOMEPAGE=https://github.com/OpenAtomFoundation/pika
NEOTERM_PKG_DESCRIPTION="A persistent huge storage service, compatible with the vast majority of Redis interfaces"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.4.1
NEOTERM_PKG_REVISION=9
NEOTERM_PKG_SRCURL=git+https://github.com/OpenAtomFoundation/pika
NEOTERM_PKG_DEPENDS="abseil-cpp, google-glog, libc++, libprotobuf, librocksdb"
NEOTERM_PKG_BUILD_IN_SRC=true

# ```
# [...]/src/pika_set.cc:107:58: error: cannot initialize a parameter of type
# 'long *' with an rvalue of type 'int64_t *' (aka 'long long *')
#   if (!slash::string2l(argv_[2].data(), argv_[2].size(), &cursor_)) {
#                                                          ^~~~~~~~
# ```
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_post_get_source() {
	rm -fr third/rocksdb
	rm -fr third/blackwidow/deps/rocksdb
}

neoterm_step_pre_configure() {
	neoterm_setup_protobuf

	CPPFLAGS+=" -D_LIBCPP_ENABLE_CXX17_REMOVED_FEATURES"
	CPPFLAGS+=" -DPROTOBUF_USE_DLLS"
	# from PREFIX/lib/cmake/glog/glog-targets.cmake
	CPPFLAGS+=" -DGLOG_USE_GLOG_EXPORT -DGLOG_USE_GFLAGS"
	LDFLAGS+=" $($NEOTERM_SCRIPTDIR/packages/libprotobuf/interface_link_libraries.sh)"
	export DISABLE_UPDATE_SB=1
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin output/bin/pika
	install -Dm600 -t $NEOTERM_PREFIX/share/pika conf/pika.conf
}
