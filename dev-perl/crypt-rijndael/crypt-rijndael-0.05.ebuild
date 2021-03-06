# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-cbc/crypt-cbc-2.08.ebuild,v 1.7 2004/07/14 17:02:32 agriffis Exp $

inherit perl-module

MY_P=Crypt-Rijndael-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="perl crypt::rijndael"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/D/DI/DIDO/${MY_P}.readme"
SRC_URI="http://search.cpan.org/CPAN/authors/id/D/DI/DIDO/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha hppa ~amd64 ~mips"
IUSE=""

