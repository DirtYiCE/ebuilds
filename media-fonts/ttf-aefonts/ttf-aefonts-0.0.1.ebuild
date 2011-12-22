# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit font

SRC_URI="http://ppa.launchpad.net/corenominal/ubuntu/pool/main/t/ttf-aefonts/${PN}_${PV}-0ubuntu1~ppa0.tar.gz"
HOMEPAGE="http://crunchbang.org/archives/2007/10/13/465-free-fonts-for-ubuntu/"
DESCRIPTION="465 Free Fonts for Ubuntu"
LICENSE="Freeware"
KEYWORDS="~x86 ~amd64 ~ppc"
DEPEND="app-arch/unzip"
S="${WORKDIR}/${PN}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
SLOT="0"

