TEMPLATE = app

TARGET = harbour-acid-pass
CONFIG += sailfishapp

#QT += declarative

SOURCES += acid-pass.cpp \
    settings.cpp \
    osread.cpp

HEADERS += \
    settings.h \
    osread.h

CONFIG(release, debug|release) {
    DEFINES += QT_NO_DEBUG_OUTPUT
}

OTHER_FILES +=

