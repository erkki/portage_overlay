# Distributed under the terms of the GNU General Public License v2
# $Header: $


HOMEPAGE="http://pear.php.net/package/Image_Text"
SRC_URI="http://pear.php.net/get/Image_Text-0.5.2beta2.tgz"
DESCRIPTION="Drawing graphs out of numerical data"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S="${WORKDIR}/Image_Text-0.5.2beta2"

src_install() {
	# SNMP is nuts sometimes
	addpredict /usr/share/snmp/mibs/.index

	cd ${S}
	mv ${WORKDIR}/package.xml ${S}
	pear install --nodeps -R ${D} ${S}/package.xml || die
}
