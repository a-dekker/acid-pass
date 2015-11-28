import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.acidpass.Settings 1.0


Dialog {
    id: passwordPage
    allowedOrientations: Orientation.Portrait | Orientation.Landscape
    | Orientation.LandscapeInverted
    canAccept: passwordField.text.length === 4

    MySettings {
        id: myset
    }

    property bool isHide: true
    property bool codeSet: myset.contains("access_code")

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

    Column {
        anchors.fill: parent

        DialogHeader {
            acceptText: qsTr("Save")
            cancelText: qsTr("Cancel")
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
                    pageStack.pop()
                }
                label: qsTr("Your access code")
                echoMode: isHide ? TextInput.Password : TextInput.Normal
                focus: true
            }

            IconButton {
                id: changePasswordFieldEchoMode
                icon.source: isHide ? "image://theme/icon-m-dialpad" : "image://theme/icon-m-device-lock"
                onClicked: isHide = !isHide
            }
        }
    }

    onAccepted: {
        if ( passwordField.text === "") {
            passwordField.text = "wrong"
        }
        setPasswd()
    }
}
