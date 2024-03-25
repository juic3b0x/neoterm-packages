NEOTERM_SUBPKG_INCLUDE="
opt/openjdk/include/jawt.h
opt/openjdk/include/linux/jawt_md.h
opt/openjdk/jmods/java.desktop.jmod
opt/openjdk/lib/libawt_xawt.so
opt/openjdk/lib/libfontmanager.so
opt/openjdk/lib/libjawt.so
opt/openjdk/lib/libsplashscreen.so
"
NEOTERM_SUBPKG_DESCRIPTION="Portion of openjdk-17 requiring X11 functionality"
NEOTERM_SUBPKG_DEPENDS="fontconfig, freetype, giflib, libandroid-shmem, libpng, libx11, libxext, libxi, libxrandr, libxrender, libxt, libxtst"
NEOTERM_SUBPKG_BREAKS="openjdk-17 (<< 17.0-25)"
NEOTERM_SUBPKG_REPLACES="openjdk-17 (<< 17.0-25)"
