################################################################################
#
# intelce-vidpproc_fw
#
################################################################################
INTELCE_VIDPPROC_FW_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDPPROC_FW_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_VIDPPROC_FW_SITE_METHOD = local
INTELCE_VIDPPROC_FW_LICENSE = PROPRIETARY
INTELCE_VIDPPROC_FW_REDISTRIBUTE = NO
INTELCE_VIDPPROC_FW_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal linux intelce-platform_config intelce-smd_tools intelce-sven intelce-core intelce-SMD_Common intelce-htuple
INTELCE_VIDPPROC_FW_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_VIDPPROC_FW_DEPENDENCIES += intelce-fw_load 
endif


ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
    INTELCE_VIDPPROC_FW_DEPENDENCIES += intelce-ipclib
endif


INTELCE_VIDPPROC_FW_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_VIDPPROC_FW_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_VIDPPROC_FW_CONFIGURE_CMDS
   
endef

define INTELCE_VIDPPROC_FW_BUILD_CMDS
    if [ -d "${INTELCE_VIDPPROC_FW_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_VIDPPROC_FW_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_VIDPPROC_FW_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_VIDPPROC_FW_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_VIDPPROC_FW_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_VIDPPROC_FW_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_VIDPPROC_FW_BUILD_ENV} ${INTELCESDK-BUILD} vidpproc_fw
endef

define INTELCE_VIDPPROC_FW_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_VIDPPROC_FW_DIR}/build_i686/staging_dir) 
endef

define INTELCE_VIDPPROC_FW_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_VIDPPROC_FW_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))