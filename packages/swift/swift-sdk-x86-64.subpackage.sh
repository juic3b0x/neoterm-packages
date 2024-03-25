NEOTERM_SUBPKG_DESCRIPTION="Swift SDK for Android x86_64"
NEOTERM_SUBPKG_INCLUDE="
lib/swift/android/x86_64/*.swiftdoc
lib/swift/android/x86_64/*.swiftmodule
lib/swift/android/x86_64/glibc.modulemap
lib/swift/android/x86_64/libswiftCxx.a
lib/swift/android/x86_64/SwiftGlibc.h
lib/swift/android/x86_64/swiftrt.o
lib/swift/android/*.swiftmodule/x86_64-*
lib/swift_static/android/x86_64/
lib/swift_static/android/*.swiftmodule/x86_64-*
"
NEOTERM_SUBPKG_PLATFORM_INDEPENDENT=true
NEOTERM_SUBPKG_DEPENDS="swift-runtime-x86-64"
NEOTERM_SUBPKG_BREAKS="swift (<< 5.8)"
NEOTERM_SUBPKG_REPLACES="swift (<< 5.8)"
