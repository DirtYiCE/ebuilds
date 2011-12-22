EAPI="4"

DESCRIPTION="SNG compiler/decompiler"
HOMEPAGE="http://sng.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND=">=media-libs/libpng-1.1.0"
DEPEND="${RDEPEND}
	x11-apps/rgb"

src_configure() {
	econf --with-rgbtxt=/usr/share/X11/rgb.txt
}