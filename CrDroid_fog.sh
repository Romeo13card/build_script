#!/bin/bash

# Клонирование дерева устройства
git clone https://github.com/alternoegraha/device_xiaomi_fog -b lineage-22.2 device/xiaomi/fog || {
    echo "Ошибка при клонировании device tree"
    exit 1
}

# Автоматическое добавление строк в device.mk
DEVICE_MK="device/xiaomi/fog/device.mk"

if ! grep -q "ro.crdroid.maintainer" "$DEVICE_MK"; then
    echo -e "\n# CrDroid-specific properties" >> "$DEVICE_MK"
    echo "PRODUCT_SYSTEM_PROPERTIES += \\" >> "$DEVICE_MK"
    echo "    ro.crdroid.maintainer=\"GADGETNiK (WolfAURman Team)\" \\" >> "$DEVICE_MK"
    echo "    ro.crdroid.buildtype=Unofficial" >> "$DEVICE_MK"
    echo -e "\e[1;32mДобавлены crDroid свойства в device.mk\e[0m"
else
    echo -e "\e[1;33mСвойства уже присутствуют в device.mk – пропущено\e[0m"
fi

# Подготовка окружения
. build/envsetup.sh

# Скрипт для подписанной сборки
curl -LO https://raw.githubusercontent.com/306bobby-android/crDroid-build-signed-script/main/create-signed-env.sh
chmod +x create-signed-env.sh
./create-signed-env.sh

# Запуск lunch и brunch
lunch lineage_fog-userdebug
brunch fog
