# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

DESCRIPTION="JOSM tool to interface with Yahoo! imagery"
ESVN_REPO_URI="http://svn.openstreetmap.org/applications/editors/josm/webgrabber"
SRC_URI=""

KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2"
SLOT="0"
DEPEND=">=dev-qt/qtcore-4.4.3
	dev-qt/qtwebkit"

src_compile() {
	cd "${S}"
	make webkit-image || die 'Cannot make webkit-image'
}

src_install() {
	cd "${S}"
	dodir /usr /usr/bin

	into /usr

	dobin "${S}/webkit-image" || die 'Cannot install webkit-image'
}
