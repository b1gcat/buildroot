################################################################################
#
# strongswan
#
################################################################################


STRONGSWAN_VERSION = 5.9.11-sjw74  
STRONGSWAN_SITE = https://github.com/b1gcat/strongswan
STRONGSWAN_SITE_METHOD = git

STRONGSWAN_LICENSE = GPL-2.0+
STRONGSWAN_LICENSE_FILES = COPYING LICENSE
STRONGSWAN_CPE_ID_VENDOR = strongswan
STRONGSWAN_DEPENDENCIES = host-pkgconf
STRONGSWAN_INSTALL_STAGING = YES
STRONGSWAN_AUTORECONF = YES


STRONGSWAN_CONF_OPTS += \
	--enable-openssl --enable-af-alg=yes--enable-unity=yes --enable-pkcs11=yes

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
STRONGSWAN_CONF_ENV += LIBS='-latomic'
endif

STRONGSWAN_DEPENDENCIES += \
	$(if $(BR2_PACKAGE_STRONGSWAN_BOTAN),botan) \
	$(if $(BR2_PACKAGE_STRONGSWAN_OPENSSL),openssl) \
	$(if $(BR2_PACKAGE_STRONGSWAN_GCRYPT),libgcrypt) \
	$(if $(BR2_PACKAGE_STRONGSWAN_GMP),gmp) \
	$(if $(BR2_PACKAGE_STRONGSWAN_EAP_AKA_3GPP2),gmp) \
	$(if $(BR2_PACKAGE_STRONGSWAN_CURL),libcurl) \
	$(if $(BR2_PACKAGE_STRONGSWAN_TNCCS_11),libxml2) \
	$(if $(BR2_PACKAGE_STRONGSWAN_EAP_SIM_PCSC),pcsc-lite) \
	$(if $(BR2_PACKAGE_STRONGSWAN_WOLFSSL),wolfssl)

ifeq ($(BR2_PACKAGE_STRONGSWAN_SQL),y)
STRONGSWAN_DEPENDENCIES += \
	$(if $(BR2_PACKAGE_SQLITE),sqlite) \
	$(if $(BR2_PACKAGE_MYSQL),mysql)
endif

# disable connmark/forecast until net/if.h vs. linux/if.h conflict resolved
# problem exist since linux 4.5 header changes
STRONGSWAN_CONF_OPTS += \
	--disable-connmark \
	--disable-forecast

$(eval $(autotools-package))
