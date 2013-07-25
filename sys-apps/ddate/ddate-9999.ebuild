EAPI=5

inherit git-2 cmake-utils

DESCRIPTION="The ddate source ripped out of util-linux"
HOMEPAGE="https://github.com/bo0ts/ddate"
EGIT_REPO_URI="git://github.com/bo0ts/ddate.git"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~*"

src_unpack() {
	git-2_src_unpack
}
