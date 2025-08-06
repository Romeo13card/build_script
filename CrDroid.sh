#! /bin/bash

# Remove Manifests
rm -rf .repo/local_manifests

# ROM Repo
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs && \

# Sync Rom
repo sync && \

# Trees

# Device Tree
rm -rf device/xiaomi/xun
git clone https://github.com/Romeo13card/android_device_xiaomi_xun -b lineage-22.2 device/xiaomi/xun && \

# Vendor Tree
rm -rf vendor/xiaomi/xun
git clone https://github.com/Xiaomi-Redmi-Pad-SE-Resources/android_vendor_xiaomi_xun -b lineage-22.2 vendor/xiaomi/xun && \

# Kernel Tree
rm -rf kernel/xiaomi/xun
git clone https://github.com/Xiaomi-Redmi-Pad-SE-Resources/android_device_xiaomi_xun-kernel -b lineage-22.2 kernel/xiaomi/xun && \

# Hardware Tree
rm -rf hardware/xiaomi
git clone https://github.com/Xiaomi-Redmi-Pad-SE-Resources/android_hardware_xiaomi -b lineage-22.2 hardware/xiaomi && \

# Build
. build/envsetup.sh && \
lunch lineage_xun-userdebug && \
mka bacon
