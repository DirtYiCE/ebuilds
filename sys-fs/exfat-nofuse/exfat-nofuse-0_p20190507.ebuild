# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod

DESCRIPTION="Non-fuse kernel driver for exFat and VFat file systems"
HOMEPAGE="https://github.com/barrybingo/exfat-nofuse"

COMMIT="c0915bb591d6fc1cb7b333f449591b663936c3d6"
SRC_URI="https://github.com/barrybingo/${PN}/archive/${COMMIT}.tar.gz -> ${PN}-${COMMIT}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${COMMIT}"

MODULE_NAMES="exfat(kernel/fs:${S})"
BUILD_TARGETS="all"

src_prepare(){
	sed -i -e "/^KREL/,2d" Makefile || die

	default
}
src_compile(){
	BUILD_PARAMS="KDIR=${KV_OUT_DIR} M=${S}"
	linux-mod_src_compile
}
