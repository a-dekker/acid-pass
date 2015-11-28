PROJECT = harbour-acid-pass
TARGET = acid-passhelper
QT -= gui
#CONFIG += sailfishapp

target.path = /usr/share/$$PROJECT/helper

SOURCES += \
    acid-pass-helper.c

INSTALLS += target
