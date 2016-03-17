# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop on filename must be changed
#   -  filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-acid-pass

CONFIG += sailfishapp

TEMPLATE = subdirs
SUBDIRS = src/acid-pass-helper src

OTHER_FILES += qml/acid-pass.qml \
    qml/cover/CoverPage.qml \
    rpm/acid-pass.changes.in \
    rpm/acid-pass.spec \
    translations/*.ts \
    harbour-acid-pass.desktop \
    qml/pages/About.qml \
    qml/pages/MainPage.qml \
    qml/pages/PasswordPage.qml \
    icons/eye-open.png \
    icons/eye-close.png \
    helper/acid-passhelper.sh \
    rpm/acid-pass.spec

INSTALLS += translations

TRANSLATIONS = translations/harbour-acid-pass-sv.ts \
               translations/harbour-acid-pass-ru.ts \
               translations/harbour-acid-pass-nl.ts \
               translations/harbour-acid-pass-de.ts \
               translations/harbour-acid-pass-cs_CZ.ts

# only include these files for translation:
lupdate_only {
    SOURCES = qml/*.qml \
              qml/pages/*.qml
}

script.files = helper/*
script.path = /usr/share/harbour-acid-pass/helper

iconeye.files += icons/eye-*.png
iconeye.path = /usr/share/harbour-acid-pass/icons

icon86.files += icons/86x86/harbour-acid-pass.png
icon86.path = /usr/share/icons/hicolor/86x86/apps

icon108.files += icons/108x108/harbour-acid-pass.png
icon108.path = /usr/share/icons/hicolor/108x108/apps

icon128.files += icons/128x128/harbour-acid-pass.png
icon128.path = /usr/share/icons/hicolor/128x128/apps

icon256.files += icons/256x256/harbour-acid-pass.png
icon256.path = /usr/share/icons/hicolor/256x256/apps

INSTALLS += icon86 icon108 icon128 icon256 script iconeye

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
