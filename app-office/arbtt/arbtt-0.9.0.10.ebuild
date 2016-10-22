# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

# ebuild generated by hackport 0.5

CABAL_FEATURES="bin test-suite"
inherit haskell-cabal

DESCRIPTION="Automatic Rule-Based Time Tracker"
HOMEPAGE="http://arbtt.nomeata.de/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/aeson-0.6:= <dev-haskell/aeson-1.1:=
	>=dev-haskell/binary-0.5:=
	dev-haskell/bytestring-progress:=
	dev-haskell/old-locale:=
	>=dev-haskell/parsec-3:= <dev-haskell/parsec-4:=
	dev-haskell/pcre-light:=
	dev-haskell/strict:=
	dev-haskell/terminal-progress-bar:=
	dev-haskell/transformers:=
	dev-haskell/utf8-string:=
	>dev-haskell/x11-1.4.4:=
	>=dev-lang/ghc-7.8.2:=
	x11-libs/libXScrnSaver
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( >=dev-haskell/tasty-0.7 <dev-haskell/tasty-0.12
		>=dev-haskell/tasty-golden-2.2.0.2 <=dev-haskell/tasty-golden-2.4
		>=dev-haskell/tasty-hunit-0.2 <dev-haskell/tasty-hunit-0.11
		|| ( ( >=dev-haskell/process-extras-0.2 <dev-haskell/process-extras-0.3 )
			|| ( ( >=dev-haskell/process-extras-0.3 <dev-haskell/process-extras-0.4 )
				( >=dev-haskell/process-extras-0.4 <dev-haskell/process-extras-0.5 ) ) ) )
"
