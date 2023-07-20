################################################################################
#
# sjw74 
#
################################################################################

SJW74_VERSION := 4.0.x
SJW74_SITE := $(CURDIR)/dl/sjw74
SJW74_SITE_METHOD := local
SJW74_INSTALL_TARGET := YES

define SJW74_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" TARGET="$(TARGET_DIR)" -C $(@D) all
endef


define SJW74_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 $(@D)/S99sjw74 \
                    $(TARGET_DIR)/etc/init.d/S99sjw74
endef


$(eval $(generic-package))
