#
# Copyright (c) 2014 The Android Open-Source Project
# Copyright (c) 2024 YAAP
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from framework configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from spes device configuration
$(call inherit-product, device/xiaomi/spes/device.mk)

# Inherit some common Yaap stuff.
$(call inherit-product, vendor/yaap/config/common.mk)

# Include Pixel Launcher
INCLUDE_PIXEL_LAUNCHER := true

# Device identifier
PRODUCT_NAME := yaap_spes
PRODUCT_DEVICE := spes
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi Note 11
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Bootanimation
TARGET_BOOT_ANIMATION_RES := 1080
