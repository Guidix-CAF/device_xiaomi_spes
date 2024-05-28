#!/bin/bash
#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        vendor/lib64/vendor.qti.hardware.camera.postproc@1.0-service-impl.so)
            "${SIGSCAN}" -p "13 0A 00 94" -P "1F 20 03 D5" -f "${2}"
            ;;
        vendor/lib64/camera/components/com.qti.node.mialgocontrol.so)
            "${ANDROID_ROOT}"/prebuilts/clang/host/linux-x86/clang-r450784e/bin/llvm-strip --strip-debug "${2}"
            grep -q "libpiex_shim.so" "${2}" || ${PATCHELF} --add-needed "libpiex_shim.so" "${2}"
            ;;
        vendor/lib/android.hardware.camera.provider@2.4-legacy.so | vendor/lib64/android.hardware.camera.provider@2.4-legacy.so)
            grep -q "libcamera_provider_shim.so" "${2}" || "${PATCHELF}" --add-needed "libcamera_provider_shim.so" "${2}"
            ;;
        vendor/bin/batterysecret | vendor/lib64/hw/fingerprint.fpc.default.so | vendor/lib64/sensors.touch.detect.so)
            "${PATCHELF}" --remove-needed libhidltransport.so "${2}"
            ;;
        vendor/lib64/libgoodixhwfingerprint.so)
            "${PATCHELF}" --remove-needed libhidltransport.so "${2}"
            "${PATCHELF}" --remove-needed libhwbinder.so "${2}"
            ;;
        vendor/lib64/libgf_ca.so)
            "${PATCHELF}" --remove-needed libhwbinder.so "${2}"
            ;;
        vendor/etc/init/init.batterysecret.rc)
            sed -i "/seclabel u:r:batterysecret:s0/d" "${2}"
            ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=spes
export DEVICE_COMMON=sm6225-common
export VENDOR=xiaomi

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
