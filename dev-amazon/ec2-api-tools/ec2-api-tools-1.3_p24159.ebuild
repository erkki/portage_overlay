# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator

EC2_VERSION=$(get_version_component_range 1-2)
EC2_PATCHLEVEL=$(get_version_component_range 3)
EC2_PATCHLEVEL=${EC2_PATCHLEVEL:1}

DESCRIPTION="These command-line tools serve as the client interface to the Amazon EC2 web service. Use these tools to register and launch instances, manipulate security groups, and more."
HOMEPAGE="http://developer.amazonwebservices.com/connect/entry.jspa?externalID=351&categoryID=88"
SRC_URI="http://s3.amazonaws.com/ec2-downloads/${PN}-${EC2_VERSION}-${EC2_PATCHLEVEL}.zip"

LICENSE="GPL-2, APACHE"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND="virtual/jre"


src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/${PN}-${EC2_VERSION}-${EC2_PATCHLEVEL}"
	find . -name *.cmd -exec rm {} \;
}

src_install() {
	dodir /opt/ec2/
	cd "${WORKDIR}/${PN}-${EC2_VERSION}-${EC2_PATCHLEVEL}"
	cp -R bin lib "${D}/opt/ec2/" || die "install failed"
	doenvd "${FILESDIR}"/99ec2
	dodoc THIRDPARTYLICENSE.TXT
}

src_test() {
	cd "${WORKDIR}/${PN}-${EC2_VERSION}-${EC2_PATCHLEVEL}/bin"
	ec2ver=$(./ec2ver)
	ec2ver=${ec2ver% *}
	[[ "${ec2ver}" != "${EC2_VERSION}-${EC2_PATCHLEVEL}" ]] && die "Wrong source package installed.  Make sure you downloaded the correct ec2-api-tools.zip (ie unzip and see)"
}

pkg_postinst() {
	elog ""
	ewarn "Remember to run: env-update && source /etc/profile if you plan"
	ewarn "to use these tools in a shell before logging out (or restarting" 
	ewarn "your login manager)"
	elog ""
	elog "You need to put the following in your ~/.bashrc replacing the"
	elog "values with the full paths to your key and certificate."
	elog " "
	elog "	export EC2_PRIVATE_KEY=/path/to/pk-HKZYKTAIG2ECMXYIBH3HXV4ZBZQ55CLO.pem"
	elog "	export EC2_CERT=/path/to/cert-HKZYKTAIG2ECMXYIBH3HXV4ZBZQ55CLO.pem"
	elog ""
	elog "Also check for a line(s) similar to this in ~/.bash_profile so that" 
	elog "you can use non-interactive terminals (ie VTs) as well:" 
	elog ''
	elog "	if [ -f ~/.bashrc ]; then source ~/.bashrc; fi"
	elog ""
	elog "If it's your first time working with Amazon's EC2 it is highly recommended"
	elog "to read the Amazon's Getting Started Guide at:" 
	elog ""
	elog "http://docs.amazonwebservices.com/AWSEC2/2008-05-05/GettingStartedGuide/"
	elog ""
}
