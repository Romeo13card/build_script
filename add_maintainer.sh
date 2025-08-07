#!/bin/bash

# Путь к репозиторию crDroid Settings
CRDROID_DIR="android_packages_apps_crDroidSettings"

# Файлы
XML_FILE="$CRDROID_DIR/res/xml/crdroid_settings_about.xml"
JAVA_FILE="$CRDROID_DIR/src/com/crdroid/settings/fragments/About.java"

# Проверка наличия файлов
if [[ ! -f "$XML_FILE" || ! -f "$JAVA_FILE" ]]; then
    echo "Ошибка: XML или Java файл не найден."
    exit 1
fi

# === Добавление Preference в XML ===

# Проверка на существование блока, чтобы не дублировать
if ! grep -q "pref_maintainer_link" "$XML_FILE"; then
    echo "Добавление Preference в $XML_FILE..."

    # Добавляем блок перед </PreferenceScreen>
    sed -i '/<\/PreferenceScreen>/i \
    <Preference\
        android:key="pref_maintainer_link"\
        android:title="Telegram"\
        android:summary="GADGETNiK"\
        android:widgetLayout="@null"\
        android:selectable="true" />' "$XML_FILE"
else
    echo "Preference уже добавлен в XML."
fi

# === Добавление обработчика в Java ===

# Проверка на существование кода
if ! grep -q "pref_maintainer_link" "$JAVA_FILE"; then
    echo "Добавление обработчика в $JAVA_FILE..."

    # Добавление импорта, если его нет
    grep -q "import android.content.Intent;" "$JAVA_FILE" || \
        sed -i '/^import/a import android.content.Intent;\nimport android.net.Uri;\nimport androidx.preference.Preference;' "$JAVA_FILE"

    # Вставка логики в метод onCreatePreferences
    sed -i '/setPreferencesFromResource/a \
        Preference maint = findPreference("pref_maintainer_link");\
        if (maint != null) {\
            maint.setOnPreferenceClickListener(p -> {\
                startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("http://t.me/GADGETNiK")));\
                return true;\
            });\
        }' "$JAVA_FILE"
else
    echo "Обработчик уже добавлен в Java."
fi

echo "✅ Ссылка на Telegram успешно добавлена."
