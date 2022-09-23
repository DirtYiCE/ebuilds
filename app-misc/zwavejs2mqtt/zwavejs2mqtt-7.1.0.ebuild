EAPI=8

inherit estack

DESCRIPTION="Zwave to Mqtt gateway and Control Panel Web UI"
HOMEPAGE="https://zwave-js.github.io/zwavejs2mqtt/"
SRC_URI="https://github.com/zwave-js/zwavejs2mqtt/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
        acct-group/zwavejs2mqtt
        acct-user/zwavejs2mqtt
"
RDEPEND="
	net-libs/nodejs:=[icu]
	!app-misc/zwavejs2mqtt-bin
"
BDEPEND="
	net-libs/nodejs:=[icu]
	sys-apps/yarn
"

RESTRICT="network-sandbox"

PATCHES="${FILESDIR}/fix-cwd.patch"

src_compile() {
	npm_config_build_from_source=true yarn install || die
	yarn run build || die

	eshopts_push -s globstar
	rm -fR node_modules/**/{prebuilds,obj.target} || die
	eshopts_pop
	find . -type d -empty -delete || die
	find . -type f '(' -name '*.ts*' -o -name '*.map' -o -iname '*.md' ')' -delete || die
}

src_install() {
	insinto /usr/share/zwavejs2mqtt
	doins -r server
	doins -r views
	doins -r static
	doins -r dist
	doins -r snippets
	doins -r node_modules

	newbin "${FILESDIR}/zwavejs2mqtt.sh" zwavejs2mqtt

	newinitd "${FILESDIR}/init" zwavejs2mqtt
	keepdir /var/lib/zwavejs2mqtt
	fowners -R zwavejs2mqtt:zwavejs2mqtt /var/lib/zwavejs2mqtt
	keepdir /var/log/zwavejs2mqtt
	fowners -R zwavejs2mqtt:zwavejs2mqtt /var/log/zwavejs2mqtt
}
