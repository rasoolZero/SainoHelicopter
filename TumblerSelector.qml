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

    delegate: Row{

        required property var modelData
        required property int index
        opacity: 1.0 - Math.abs(Tumbler.displacement) / (control.visibleItemCount / 2)
        anchors.horizontalCenter: parent.horizontalCenter
        spacing : width*0.1
        leftPadding: width*0.15
        Image{
            height : hideText ? parent.height*0.5 : parent.height*0.35
            anchors.verticalCenter: parent.verticalCenter
            source : "qrc:/assets/" + control.icons[parent.index] + ".svg"
            smooth: true
            // mipmap: true
            fillMode: Image.PreserveAspectFit
            ColorOverlay{
                anchors.fill: parent
                source:parent
                antialiasing: true
                smooth:true
                color:"white"
            }
        }
        Text {
            text: parent.modelData
            font: control.font
            verticalAlignment: Text.AlignVCenter
            color: control.textColor
            height : parent.height
            visible: !hideText
            enabled: visible
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
