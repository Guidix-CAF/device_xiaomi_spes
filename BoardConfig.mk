# Copyright (C) 2023 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DEVICE_PATH := device/xiaomi/spes

# Board Info
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/configs/hidl/xiaomi_manifest.xml

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):libinit_spes
TARGET_RECOVERY_DEVICE_MODULES := libinit_spes

# Kernel
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CONFIG := vendor/spes-perf_defconfig
TARGET_KERNEL_SOURCE := kernel/xiaomi/spes

BOARD_KERNEL_CMDLINE +=  init.is_dt2w_sensor=1
BOARD_KERNEL_CMDLINE +=  init.is_st2w_sensor=1

# OTA assert
TARGET_OTA_ASSERT_DEVICE := spes,spesn

# Screen density
TARGET_SCREEN_DENSITY := 440

# Sensors
SOONG_CONFIG_NAMESPACES += SENSORS_XIAOMI
SOONG_CONFIG_SENSORS_XIAOMI += USES_DOUBLE_TAP_SENSOR
SOONG_CONFIG_SENSORS_XIAOMI_USES_DOUBLE_TAP_SENSOR := true
SOONG_CONFIG_SENSORS_XIAOMI += USES_SINGLE_TAP_SENSOR
SOONG_CONFIG_SENSORS_XIAOMI_USES_SINGLE_TAP_SENSOR := true

# Sepolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/public

# Inherit from the proprietary version
include vendor/xiaomi/spes/BoardConfigVendor.mk

# Inherit from sm6225-common
include device/xiaomi/sm6225-common/BoardConfigCommon.mk
