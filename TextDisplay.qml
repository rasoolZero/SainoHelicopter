import QtQuick
import Qt5Compat.GraphicalEffects


Item {
    property alias frameColor : frameOverlay.color
    property alias text: text.text
    property alias textColor: text.color

    Image{
        id: frame
        source:"assets/frame.svg"
        anchors.fill: parent
        smooth: true
        antialiasing: true
    }

    ColorOverlay{
        id: frameOverlay
        anchors.fill: frame
        source: frame
        antialiasing: true
        smooth: true
    }

    Text{
        id: text
        anchors.fill: parent
        anchors.leftMargin: parent.width * 12/100
        anchors.rightMargin: parent.width * 12/100
        anchors.topMargin: parent.height * 8/100
        anchors.bottomMargin: parent.height * 8/100
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        fontSizeMode: Text.Fit
        minimumPointSize : 10
        font.pointSize: 172
        wrapMode: Text.WordWrap
    }
}
