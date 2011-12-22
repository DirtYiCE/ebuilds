# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/astyle/astyle-1.24.ebuild,v 1.2 2011/01/28 19:17:50 grobian Exp $

EAPI=4

inherit base java-pkg-opt-2 autotools

DESCRIPTION="Artistic Style is a reindenter and reformatter of C++, C and Java source code"
HOMEPAGE="http://astyle.sourceforge.net/"
SRC_URI="mirror://sourceforge/astyle/astyle_${PV}_linux.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

IUSE="java"

DEPEND="java? ( >virtual/jdk-1.6 )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}/build/gcc

src_prepare() {
	java-pkg-opt-2_src_prepare
}

src_compile() {
	emake release shared
	if use java; then
		emake java
	fi
}

src_install() {
	emake USER=root prefix="${D}usr" install

	# fix installl
	mv "${D}usr/share/doc/astyle" "${D}usr/share/doc/${P}" || die
	dolib.so bin/*.so
	insinto /usr/include
	doins ../../src/astyle.h
}
