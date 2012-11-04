# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.8.3.ebuild,v 1.10 2012/04/02 10:56:28 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Utilities for the Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/xfce-utils/"
SRC_URI="mirror://xfce/src/xfce/xfce-utils/${PV%.*}/xfce-utils-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="dbus debug +lock"

COMMON_DEPEND="x11-libs/libX11
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4ui-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfconf-4.8
	!xfce-base/xfce-utils
	dbus? ( >=dev-libs/dbus-glib-0.90 )"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

S="${WORKDIR}/xfce-utils-${PV}"

pkg_setup() {
	XFCONF=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		--disable-xfconf-migration
		$(use_enable dbus)
		$(xfconf_use_debug)
		--with-vendor-info=Gentoo
		--without-browser
		--without-terminal
		)

	DOCS=( AUTHORS ChangeLog NEWS )
}

src_install() {
	xfconf_src_install

	rm -f "${ED}"/usr/share/applications/xfhelp4.desktop

	rm -f "${ED}"/usr/share/applications/xfce4-about.desktop
	rm -f "${ED}"/usr/share/icons/hicolor/48x48/apps/xfce4-logo.png
	rm -rf "${ED}"/usr/share/xsessions
	rm -f "${ED}"/usr/bin/startxfce4
	rm -f "${ED}"/usr/bin/xfce4-about
	rm -f "${ED}"/usr/bin/xfbrowser4
	rm -f "${ED}"/usr/bin/xflock4
	rm -f "${ED}"/usr/bin/xfhelp4
	rm -f "${ED}"/usr/bin/xfmountdev4
	rm -f "${ED}"/usr/bin/xfterm4
	rm -rf "${ED}"/etc/xdg

	#echo startxfce4 > "${T}"/Xfce4
	#exeinto /etc/X11/Sessions
	#doexe "${T}"/Xfce4
}
