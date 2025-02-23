import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Tumbler {
    id: control
    property bool hideText : false

    required property color textColor
    required property color separatorColor
    property list<string> icons : [
        "description", "fuel", "battery", "temperature", "camera", "speed",
        "lamps", "rotor", "control_panel", "radio"
    ]

    model: ListModel {
        ListElement { text: "Description" }
        ListElement { text: "Fuel" }
        ListElement { text: "Battery" }
        ListElement { text: "Temperature" }
        ListElement { text: "Fixed Camera" }
        ListElement { text: "Speed" }
        ListElement { text: "Lamps" }
        ListElement { text: "Rotor Speed" }
        ListElement { text: "Control Panel" }
        ListElement { text: "Radio" }

    }

    background: Item {
        Rectangle {
            opacity: control.enabled ? 0.2 : 0.1
            border.color: "#000000"
            width: parent.width
            height: 1
            anchors.top: parent.top
        }

        Rectangle {
            opacity: control.enabled ? 0.2 : 0.1
            border.color: "#000000"
            width: parent.width
            height: 1
            anchors.bottom: parent.bottom
        }
    }

    delegate: RowLayout {

        required property var modelData
        required property int index
        readonly property real factor: (control.visibleItemCount / 2)
        opacity: 1.0 - Math.abs(Tumbler.displacement) / factor
        anchors.horizontalCenter: parent.horizontalCenter
        height: control.height*0.1
        width: control.width
        Image {
            Layout.leftMargin: hideText? 0 : parent.width * 0.1
            source: "qrc:/assets/" + control.icons[parent.index] + ".svg"
            smooth: false
            fillMode: Image.PreserveAspectFit
            ColorOverlay {
                anchors.fill: parent
                source: parent
                antialiasing: true
                smooth: false
                color: "white"
            }
            Layout.fillWidth: hideText  // Allows centering when text is hidden
            Layout.maximumWidth: control.width*0.5
            Layout.preferredWidth: hideText ? control.width*0.5 : control.width*0.35

            Layout.maximumHeight: Layout.maximumWidth/2
            Layout.preferredHeight: Layout.preferredWidth/2

            Layout.alignment: Qt.AlignHCenter
        }

        Item {
            Layout.fillWidth: !hideText // Give space to Text only if visible
            Layout.alignment: Qt.AlignLeft
            visible: !hideText

            Text {
                textFormat: Text.PlainText
                text: parent.parent.modelData
                verticalAlignment: Text.AlignVCenter
                color: control.textColor
                height: parent.height
            }
        }
    }

    Rectangle {
        anchors.horizontalCenter: control.horizontalCenter
        y: control.height * 0.4
        width: control.width * 0.8
        height: 1
        color: control.separatorColor
    }

    Rectangle {
        anchors.horizontalCenter: control.horizontalCenter
        y: control.height * 0.6
        width: control.width * 0.8
        height: 1
        color: control.separatorColor
    }
}
