# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook2X/docbook2X-0.8.8-r2.ebuild,v 1.19 2012/05/25 03:26:41 vapier Exp $

EAPI="4"

inherit autotools eutils

DESCRIPTION="Tools to convert docbook to man and info"
SRC_URI="mirror://sourceforge/docbook2x/${P}.tar.gz"
HOMEPAGE="http://docbook2x.sourceforge.net/"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-linux ~x86-solaris"
IUSE="test saxon xalan"
LICENSE="MIT"

# dev-perl/XML-LibXML - although not mentioned upstream is required
# for make check to complete.
DEPEND="dev-lang/perl
	dev-libs/libxslt
	dev-perl/XML-NamespaceSupport
	dev-perl/XML-SAX
	dev-perl/XML-LibXML
	app-text/docbook-xsl-stylesheets
	=app-text/docbook-xml-dtd-4.2*
	saxon? ( dev-java/saxon:6.5 )
	xalan? ( dev-java/xalan )"
RDEPEND="${DEPEND}"

src_prepare() {
	# Patches from debian, for description see patches itself.
	epatch "${FILESDIR}"/${P}-filename_whitespace_handling.patch
	epatch "${FILESDIR}"/${P}-preprocessor_declaration_syntax.patch
	epatch "${FILESDIR}"/${P}-error_on_missing_refentry.patch

	eautoreconf #290284
}

src_configure() {
	local myconf

	if use saxon || use xalan; then
		myconf="${myconf} --with-resolver-jars=/usr/share/xml-commons-resolver/lib/xml-commons-resolver.jar"
	fi
	use saxon && myconf="${myconf} --with-saxon-jars=/usr/share/saxon-6.5/lib/saxon.jar"
	use xalan && myconf="${myconf} --with-xalan-jars=/usr/share/xalan/lib/xalan.jar"

	econf ${myconf} \
		--with-xslt-processor=libxslt \
		--program-transform-name='/^docbook2/s,$,.pl,'
}

pkg_postinst() {
	elog "To avoid conflict with docbook-sgml-utils, which is much more widely used,"
	elog "all executables have been renamed to *.pl."
}
