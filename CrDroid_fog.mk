#! /bin/bash

# Device Tree
git clone https://github.com/alternoegraha/device_xiaomi_fog -b lineage-22.2 device/xiaomi/fog && \

# -------Setup Build Environment -------
. build/vendorsetup.sh

#Signed build
git clone get https://raw.githubusercontent.com/306bobby-android/crDroid-build-signed-script/main/create-signed-env.sh
chmod +x create-signed-env.sh
./create-signed-env.sh

#Lunch ROM
lunch lineage_fog-userdebug
brunch fog
