import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: aboutPage
    property bool largeScreen: Screen.width > 540

    SilicaFlickable {
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: col.height

        VerticalScrollDecorator {
        }

        Column {
            id: col
            spacing: Theme.paddingLarge
            width: parent.width
            PageHeader {
                title: qsTr("About")
            }
            SectionHeader {
                text: qsTr("Info")
                visible: isPortrait || (largeScreen && Screen.width > 1080)
            }
            Separator {
                color: Theme.primaryColor
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Qt.AlignHCenter
            }
            Label {
                text: "acid-pass"
                font.pixelSize: Theme.fontSizeExtraLarge
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: isLandscape ? (largeScreen ? "/usr/share/icons/hicolor/256x256/apps/harbour-acid-pass.png" : "/usr/share/icons/hicolor/86x86/apps/harbour-acid-pass.png") : (largeScreen ? "/usr/share/icons/hicolor/256x256/apps/harbour-acid-pass.png" : "/usr/share/icons/hicolor/128x128/apps/harbour-acid-pass.png")
            }
            Label {
                text: qsTr("Version") + " " + version
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.secondaryHighlightColor
            }
            Label {
                text: qsTr("Shows stored Wi-Fi related passwords")
                font.pixelSize: Theme.fontSizeSmall
                width: parent.width
                horizontalAlignment: Text.Center
                textFormat: Text.RichText
                wrapMode: Text.Wrap
                color: Theme.secondaryColor
            }
            SectionHeader {
                text: qsTr("Author")
                visible: isPortrait || (largeScreen && Screen.width > 1080)
            }
            Separator {
                color: Theme.primaryColor
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Qt.AlignHCenter
            }
            Label {
                text: "© Arno Dekker 2015-2019"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
