import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.acidpass.Settings 1.0
import org.nemomobile.notifications 1.0

Page {
    id: passwordPage

    MySettings {
        id: myset
    }

    Notification {
        id: notification
        appName: "acid-pass"
    }

    property bool isHide: true
    property bool codeSet: myset.contains("access_code")

    function banner(message) {
        notification.close()
        notification.previewBody = message
        notification.category = "x-jolla.store.error"
        notification.previewSummary = "Acid-pass"
        notification.publish()
    }

    function setPasswd() {
        if ((!codeSet || mainapp.resetCode) && passwordField.text.length === 4) {
            myset.setValue("access_code", Qt.btoa(passwordField.text))
        }
        mainapp.password = passwordField.text
        // if (mainapp.resetCode) {
        //     // prevent adding the list multiple times
        //     mainapp.fromPasswordPage = false
        // }
        mainapp.fromPasswordPage = !mainapp.resetCode
        mainapp.resetCode = false
    }

    SilicaFlickable {
        anchors.fill: parent
        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column
            width: passwordPage.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Acid-pass")
            }

            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                text: (codeSet && !mainapp.resetCode) ? qsTr("Enter your 4 digit access code") : qsTr("Set a new 4 digit access code")
                wrapMode: Text.Wrap
            }

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge

                TextField {
                    id: passwordField
                    font.family: text.trim().length > 0 ? 'monospace' : Theme.fontFamily
                    width: parent.width - changePasswordFieldEchoMode.width
                    placeholderText: qsTr("Enter access code")
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: RegExpValidator {
                        regExp: /^[0-9]{4}$/
                    }
                    EnterKey.enabled: text.trim().length === 4
                    EnterKey.highlighted: true
                    EnterKey.text: "OK"
                    EnterKey.onClicked: {
                        setPasswd()
                        if (Qt.atob(myset.value("access_code")) === mainapp.password) {
                            pageStack.pop()
                        } else {
                            passwordField.text = ""
                            banner(qsTr("Invalid access code!"))
                        }
                    }
                    label: qsTr("Your access code")
                    echoMode: isHide ? TextInput.Password : TextInput.Normal
                    focus: true
                    focusOutBehavior: -1
                }

                IconButton {
                    id: changePasswordFieldEchoMode
                    icon.height: Theme.iconSizeLarge - Theme.paddingMedium
                    icon.width: Theme.iconSizeLarge - Theme.paddingMedium
                    icon.source: isHide ? "../../icons/eye-open.png" : "../../icons/eye-close.png"
                    icon.opacity: 0.6
                    onClicked: isHide = !isHide
                }

            }
        }
    }
}
