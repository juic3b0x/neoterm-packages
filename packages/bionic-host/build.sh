NEOTERM_PKG_HOMEPAGE=https://android.googlesource.com/platform/bionic/
NEOTERM_PKG_DESCRIPTION="bionic libc, libm, libdl and dynamic linker for ubuntu host"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="8.0.0-r51"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SHA256=6b42a86fc2ec58f86862a8f09a5465af0758ce24f2ca8c3cabb3bb6a81d96525
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_SKIP_SRC_EXTRACT=true

neoterm_step_get_source() {
    if $NEOTERM_ON_DEVICE_BUILD; then
        neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
    fi
    
    case "${NEOTERM_ARCH}" in
        i686) _ARCH=x86 ;;
        aarch64) _ARCH=arm64 ;;
        *) _ARCH=${NEOTERM_ARCH} ;;
    esac

    export LD_LIBRARY_PATH="${NEOTERM_PKG_SRCDIR}/prefix/lib/x86_64-linux-gnu:${NEOTERM_PKG_SRCDIR}/prefix/usr/lib/x86_64-linux-gnu"
    export PATH="$(sed "s#/home/`whoami`/.cargo/bin:##" <<< $PATH):${NEOTERM_PKG_SRCDIR}/prefix/usr/bin:$PATH"

    mkdir -p ${NEOTERM_PKG_SRCDIR}/prefix
    cd ${NEOTERM_PKG_SRCDIR}

    cp -f ${NEOTERM_PKG_BUILDER_DIR}/LICENSE.txt ${NEOTERM_PKG_SRCDIR}/LICENSE.txt

    local PACKAGES=(
        "http://security.ubuntu.com/ubuntu/pool/universe/n/ncurses/libtinfo5_6.4-2ubuntu0.1_amd64.deb a5acc48e56ca4cd1b2e5fb22b36c5a02788c0baede55617e3f30decff58616ab"
        "http://security.ubuntu.com/ubuntu/pool/universe/n/ncurses/libncurses5_6.4-2ubuntu0.1_amd64.deb 654b4f5b41380efabf606a691174974f9304e0b3ee461d0d91712b7e024f5546"
        "https://mirror.sit.fraunhofer.de/ubuntu/pool/main/o/openssh/openssh-client_8.9p1-3ubuntu0.4_amd64.deb afb16d53e762a78fabd9ce405752cd35d2f45904355ee820ce00f67bdf530155"
    )
    for item in "${PACKAGES[@]}"; do
        local URL=$(cut -d' ' -f1 <<< $item) SHA256=$(cut -d' ' -f2 <<< $item)
        neoterm_download ${URL} ${NEOTERM_PKG_CACHEDIR}/${URL##*/} ${SHA256}

        mkdir -p ${NEOTERM_PKG_TMPDIR}/${URL##*/}
        ar x ${NEOTERM_PKG_CACHEDIR}/${URL##*/} --output=${NEOTERM_PKG_TMPDIR}/${URL##*/}
        tar xf ${NEOTERM_PKG_TMPDIR}/${URL##*/}/data.tar.zst -C ${NEOTERM_PKG_SRCDIR}/prefix
    done

    neoterm_download \
        https://storage.googleapis.com/git-repo-downloads/repo \
        ${NEOTERM_PKG_CACHEDIR}/repo \
        b03b473e2f5342acd914693a3a9d70560de6d6cd5fad2bdb8dcbb5ae170d78c9
    chmod +x ${NEOTERM_PKG_CACHEDIR}/repo
    ${NEOTERM_PKG_CACHEDIR}/repo init \
        -u https://android.googlesource.com/platform/manifest \
        -b main -m ${NEOTERM_PKG_BUILDER_DIR}/default.xml
    ${NEOTERM_PKG_CACHEDIR}/repo sync -c -j32

    sed -i '1s|.*|\#!'${NEOTERM_PKG_SRCDIR}'/prebuilts/python/linux-x86/2.7.5/bin/python2|' ${NEOTERM_PKG_SRCDIR}/bionic/libc/fs_config_generator.py
    sed -i '1s|.*|\#!'${NEOTERM_PKG_SRCDIR}'/prebuilts/python/linux-x86/2.7.5/bin/python2|' ${NEOTERM_PKG_SRCDIR}/external/clang/clang-version-inc.py
    sed -i '/selinux/d' ${NEOTERM_PKG_SRCDIR}/system/core/debuggerd/Android.bp
    sed -i '/selinux/d' ${NEOTERM_PKG_SRCDIR}/system/core/debuggerd/crash_dump.cpp
    sed -i '/selinux/d' ${NEOTERM_PKG_SRCDIR}/system/core/debuggerd/debuggerd.cpp
}

neoterm_step_configure() {
    :
}

neoterm_step_make() {
    env -i LD_LIBRARY_PATH=$LD_LIBRARY_PATH PATH=$PATH bash -c "
        set -e;
        cd ${NEOTERM_PKG_SRCDIR}
        source build/envsetup.sh;
        lunch aosp_${_ARCH}-eng;
        make JAVA_NOT_REQUIRED=true linker libc libm libdl libicuuc debuggerd crash_dump
    "
}

neoterm_step_make_install() {
    mkdir -p ${NEOTERM_PREFIX}/opt/bionic-host/usr/icu
    cp ${NEOTERM_PKG_SRCDIR}/external/icu/icu4c/source/stubdata/icudt58l.dat ${NEOTERM_PREFIX}/opt/bionic-host/usr/icu/
    cp -r ${NEOTERM_PKG_SRCDIR}/out/target/product/generic*/system/* ${NEOTERM_PREFIX}/opt/bionic-host/
}
