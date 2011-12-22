# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Tool for automatic download/upload subtitles for videofiles."
HOMEPAGE="http://www.subdownloader.net/"
SRC_URI="http://launchpad.net/${PN}/trunk/2.0.9/+download/${P}.tar.gz"
PREFIX="/usr/share"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/PyQt4 dev-python/sip"

inherit eutils

src_unpack() {
	unpack ${A}
	cd "/var/tmp/portage/media-video/subdownloader-2.0.9.3/work/subdownloader" || die
}

src_install() {
	export WD="/var/tmp/portage/media-video/subdownloader-2.0.9.3/work/subdownloader"
	insinto /usr/share/subdownloader
	cd ${WD}
	doins -r cli FileManagement gui __init__.py languages locale modules run.py subdownloader.1
	chmod +x ${WD}/run.py
	echo '#!/bin/sh' > ${WD}/subdownloader
	echo 'cd "/usr/share/subdownloader/"' >> ${WD}/subdownloader
	echo 'if [ -n "/usr/share/subdownloader/" ] ; then' >> ${WD}/subdownloader
	echo 'if [ "${LD_LIBRARY_PATH+set}" = "set" ] ; then' >> ${WD}/subdownloader
	echo 'export' >> ${WD}/subdownloader
	echo 'LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/share/subdownloader/"' >> ${WD}/subdownloader
	echo 'else' >> ${WD}/subdownloader
	echo 'export' >> ${WD}/subdownloader
	echo 'LD_LIBRARY_PATH="/usr/share/subdownloader/"' >> ${WD}/subdownloader
	echo 'fi' >> ${WD}/subdownloader
	echo 'fi' >> ${WD}/subdownloader
	echo 'python ./run.py "$@"' >> ${WD}/subdownloader
	chmod +x ${WD}/subdownloader
	dobin ${WD}/subdownloader
	doman subdownloader.1
	dodoc README ChangeLog
	doicon gui/images/subdownloader.png
	domenu subdownloader.desktop
}
