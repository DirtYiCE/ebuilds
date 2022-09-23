EAPI=8

DESCRIPTION="Caule Themes Pack 1 - by caule.studio"
HOMEPAGE="https://github.com/orickcorreia/caule-themes-pack-1"
SRC_URI="https://github.com/orickcorreia/caule-themes-pack-1/archive/refs/tags/v.${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	acct-group/homeassistant
	acct-user/homeassistant
"
RDEPEND="|| ( app-misc/homeassistant app-misc/homeassistant-min app-misc/homeassistant-full )"

S="${WORKDIR}/caule-themes-pack-1-v.${PV}"

src_compile() {
	#unzip src/backgrounds-icons.zip || die
	# the manual version is outdated
	sed -i 's|/hacsfiles/themes|/local|g' themes/caule-themes-pack-1.yaml || die
}

src_install() {
	insinto /etc/homeassistant/themes
	doins themes/caule-themes-pack-1.yaml

	insinto /etc/homeassistant/www/caule-themes-pack-1
	doins themes/*.jpg
	doins themes/*.svg

	fowners -R homeassistant:homeassistant /etc/homeassistant
}
