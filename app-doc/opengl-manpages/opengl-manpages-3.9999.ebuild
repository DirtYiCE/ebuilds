EAPI=4
inherit subversion

SLOT="${PV/.*}"
DESCRIPTION="OpenGL manpages"
HOMEPAGE="http://www.opengl.org/discussion_boards/showthread.php/165536-Man-pages-source-available-in-Khronos-Subversion"
SRC_URI="http://www.oasis-open.org/docbook/xml/mathml/1.1CR1/dbmathml.dtd
	http://www.w3.org/TR/MathML2/dtd/mathml2.dtd
	http://www.w3.org/TR/MathML2/dtd/mathml2-qname-1.mod
	http://www.w3.org/TR/MathML2/dtd/isoamsa.ent
	http://www.w3.org/TR/MathML2/dtd/isoamsb.ent
	http://www.w3.org/TR/MathML2/dtd/isoamsc.ent
	http://www.w3.org/TR/MathML2/dtd/isoamsn.ent
	http://www.w3.org/TR/MathML2/dtd/isoamso.ent
	http://www.w3.org/TR/MathML2/dtd/isoamsr.ent
	http://www.w3.org/TR/MathML2/dtd/isogrk3.ent
	http://www.w3.org/TR/MathML2/dtd/isomfrk.ent
	http://www.w3.org/TR/MathML2/dtd/isomopf.ent
	http://www.w3.org/TR/MathML2/dtd/isomscr.ent
	http://www.w3.org/TR/MathML2/dtd/isotech.ent
	http://www.w3.org/TR/MathML2/dtd/isobox.ent
	http://www.w3.org/TR/MathML2/dtd/isocyr1.ent
	http://www.w3.org/TR/MathML2/dtd/isocyr2.ent
	http://www.w3.org/TR/MathML2/dtd/isodia.ent
	http://www.w3.org/TR/MathML2/dtd/isolat1.ent
	http://www.w3.org/TR/MathML2/dtd/isolat2.ent
	http://www.w3.org/TR/MathML2/dtd/isonum.ent
	http://www.w3.org/TR/MathML2/dtd/isopub.ent
	http://www.w3.org/TR/MathML2/dtd/isolat1.ent
	http://www.w3.org/TR/MathML2/dtd/mmlextra.ent
	http://www.w3.org/TR/MathML2/dtd/mmlalias.ent"
ESVN_REPO_URI="https://cvs.khronos.org/svn/repos/ogl/trunk/ecosystem/public/sdk/docs/man${SLOT}"
ESVN_USER="anonymous"
ESVN_PASSWORD="anonymous"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-text/docbook2X"
RDEPEND=""

src_unpack() {
	subversion_src_unpack

	for i in ${A}; do
		cp "${DISTDIR}/${i}" ./ || die
	done
	cp "${FILESDIR}"/catalog ./ || die
}

src_compile() {
	for f in *.xml; do
		einfo "Processing ${f}"
		docbook2man.pl --solinks --catalogs=../catalog --encoding=utf-8 \
			"${f}" || die
	done
}

src_install() {
	for i in *.3G; do
		mv "${i}" "`basename "${i}" .3G`.3G${SLOT}"
	done
	doman *.3G"${SLOT}"
}
