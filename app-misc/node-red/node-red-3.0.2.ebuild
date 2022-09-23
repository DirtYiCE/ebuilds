EAPI=8

inherit estack

DESCRIPTION="Low-code programming for event-driven applications"
HOMEPAGE="https://nodered.org/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="home-assistant"

DEPEND="
        acct-group/node_red
        acct-user/node_red
"
RDEPEND=">=net-libs/nodejs-12.0"
BDEPEND="${RDEPEND}"

RESTRICT="network-sandbox"

S="${WORKDIR}"

src_compile() {
	npm install --build-from-source node-red@3.0.2 || die
	usex home-assistant && npm install --build-from-source node-red-contrib-home-assistant-websocket@0.44.0
	eshopts_push -s globstar
	rm -fR node_modules/**/{prebuilds,obj.target} || die
	eshopts_pop
}

src_install() {
	dodir /usr/share/node-red
	cp -R node_modules "${D}/usr/share/node-red/"

	dosym "${EPREFIX}/usr/share/node-red/node_modules/.bin/node-red" /usr/bin/node-red

	newinitd "${FILESDIR}/init" node-red
	newconfd "${FILESDIR}/conf" node-red
	keepdir /var/lib/node-red
	fowners -R node_red:node_red /var/lib/node-red
	keepdir /var/log/node-red
	fowners -R node_red:node_red /var/log/node-red
}
