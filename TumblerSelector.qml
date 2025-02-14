import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Controls

Tumbler {
    id: control

    required property color textColor
    required property color separatorColor

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

    delegate: Text {
        text: modelData
        font: control.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        opacity: 1.0 - Math.abs(Tumbler.displacement) / (control.visibleItemCount / 2)
        color: control.textColor
        required property var modelData
        required property int index
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
