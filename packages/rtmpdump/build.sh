NEOTERM_PKG_HOMEPAGE=https://rtmpdump.mplayerhq.hu/
NEOTERM_PKG_DESCRIPTION="Small dumper for media content streamed over the RTMP protocol"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
# NOTE: Special handling of unofficial support for openssl 1.1 from
# https://gitlab.com/JudgeZarbi/RTMPDump-OpenSSL-1.1
NEOTERM_PKG_VERSION=2.4
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_SRCURL=https://gitlab.com/JudgeZarbi/RTMPDump-OpenSSL-1.1/-/archive/019592918b0f961104eaf71b56c1db0fa26ed497/RTMPDump-OpenSSL-1.1-019592918b0f961104eaf71b56c1db0fa26ed497.tar.bz2
NEOTERM_PKG_SHA256=42978d5b1cfe9fe4e01305f81c183935056a6c1ad46b9cd2e582f9147196fa87
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="openssl, zlib"
NEOTERM_PKG_BREAKS="rtmpdump-dev"
NEOTERM_PKG_REPLACES="rtmpdump-dev"
