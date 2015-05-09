EAPI=5
inherit git-2

DESCRIPTION="cppreference.org c+++ manpages"
HOMEPAGE="http://en.cppreference.com/w/Cppreference:Archives"
SLOT=0

EGIT_REPO_URI="https://github.com/jeaye/stdman.git"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	sed -i '/gzip/d' do_install || die
}

src_configure() {
	./configure --prefix=/usr || die "configure failed"
}

src_compile() { :;}
