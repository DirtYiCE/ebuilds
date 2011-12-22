# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
inherit subversion
inherit scons-utils

DESCRIPTION="OpenCOLLADA is a stream based reader and writer library for COLLADA files"
HOMEPAGE="http://www.opencollada.org/"
LICENSE="MIT"

ESVN_REPO_URI="http://opencollada.googlecode.com/svn/trunk"
ESVN_PROJECT="opencollada-trunk"
ESVN_PATCHES="${FILESDIR}/opencollada-r833-include.patch"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	# call configure for bundled expat to generate a missing header file
	cd $S/Externals/expat
	sh configure

	cd $S
	escons RELEASE=1 XMLPARSER=expat PCRENATIVE=0
}

src_install() {
	#dodir /usr/include/opencollada/
	#dodir /usr/lib/opencollada/
	dolib $S/*/lib/posix/*/*/*.a
	for i in $S/*/include; do
		insinto /usr/include/opencollada/${i/$S}
		doins -r $i/*
	done
}
