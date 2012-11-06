# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/luajit/luajit-2.0.0_beta8_p1.ebuild,v 1.1 2011/10/30 21:21:57 flameeyes Exp $

EAPI="4"

inherit eutils multilib pax-utils versionator toolchain-funcs

MY_P="LuaJIT-$(get_version_component_range 1-3)-$(get_version_component_range 4)"
if [[ $(get_version_component_range 5) != "" ]]; then
	HOTFIX="$(get_version_component_range 4-5)"
	HOTFIX="${HOTFIX/_p/_hotfix}.patch"
fi

DESCRIPTION="Just-In-Time Compiler for the Lua programming language"
HOMEPAGE="http://luajit.org/"
SRC_URI="http://luajit.org/download/${MY_P}.tar.gz
	${HOTFIX:+http://luajit.org/download/${HOTFIX}}"

LICENSE="MIT"
# this should probably be pkgmoved to 2.0 for sake of consistency.
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""
ABIVER="5.1"

S="${WORKDIR}/${MY_P}"

src_prepare(){
	if [[ -n ${HOTFIX} ]]; then
		epatch "${DISTDIR}/${HOTFIX}"
	fi

	sed -i -e "s|/usr/local|/usr|" \
		-e "s|/lib|/$(get_libdir)|" \
		Makefile || die
}

src_compile() {
	emake \
		DESTDIR="${D}" \
		HOST_CC="$(tc-getBUILD_CC)" \
		STATIC_CC="$(tc-getCC)" \
		DYNAMIC_CC="$(tc-getCC) -fPIC" \
		TARGET_LD="$(tc-getCC)" \
		TARGET_AR="$(tc-getAR) rcus" \
		TARGET_STRIP="true" \
		LDCONFIG="true" \
		LIBDIR="$(get_libdir)" \
		Q="" E="@:"
}

src_install(){
	emake install \
		DESTDIR="${D}" \
		HOST_CC="$(tc-getBUILD_CC)" \
		STATIC_CC="$(tc-getCC)" \
		DYNAMIC_CC="$(tc-getCC) -fPIC" \
		TARGET_LD="$(tc-getCC)" \
		TARGET_AR="$(tc-getAR) rcus" \
		TARGET_STRIP="true" \
		LDCONFIG="true" \
		LIBDIR="$(get_libdir)"

	dosym "libluajit-${ABIVER}.so.${PV/_*}" "/usr/$(get_libdir)/libluajit-${ABIVER}.so.${PV/.*}"
	pax-mark m "${D}usr/bin/luajit-2.0"

	cd "${S}"/doc
	dohtml -r *
}