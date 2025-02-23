import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick3D


Item {
    property alias frameColor : frameOverlay.color
    property alias text: text.text
    property alias textColor: text.color
    property alias backgroundColor : background.color

    Rectangle{
        id: background
        anchors.fill:parent
        anchors.leftMargin: parent.width * 7/100
        anchors.rightMargin: parent.width * 7/100
        anchors.topMargin: parent.height * 4/100
        anchors.bottomMargin: parent.height * 4/100
    }

    Image{
        id: frame
        source:"qrc:/assets/frame.svg"
        anchors.fill: parent
        smooth: false
        antialiasing: true
        mipmap: true
    }

    ColorOverlay{
        id: frameOverlay
        anchors.fill: frame
        source: frame
        antialiasing: true
        smooth: false
    }

    Text{
        id: text
        textFormat: Text.PlainText
        readonly property real horzizontalMargin: parent.width * 11/100
        readonly property real verticalMargin: parent.height * 7/100
        anchors.fill: parent
        anchors.leftMargin: horzizontalMargin
        anchors.rightMargin: horzizontalMargin
        anchors.topMargin: verticalMargin
        anchors.bottomMargin: verticalMargin
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        fontSizeMode: Text.Fit
        minimumPointSize : 10
        font.pointSize: 172
        wrapMode: Text.WordWrap
        // onContentHeightChanged: {
        //     console.log("\ncontentHeight:",contentHeight
        //                 ,"\nheight:",height
        //                 ,"implicitHeight:",implicitHeight)
        // }
    }

    LinearGradient{
        id: mask
        anchors.fill: frameOverlay
        start:Qt.point(0,0)
        end:Qt.point(width*2,height)
        gradient: Gradient {
            id: maskGradient
            property real position : 0.4
            GradientStop { position: 0.0; color: "transparent"}
            GradientStop { position: maskGradient.position - 0.01 - 0.001; color: "transparent"}
            GradientStop { position: maskGradient.position - 0.01; color: "white"}
            GradientStop { position: maskGradient.position + 0.01; color: "white"}
            GradientStop { position: maskGradient.position + 0.01 + 0.001; color: "transparent"}
            GradientStop { position: 1.0; color: "transparent"}

            SequentialAnimation on position{
                loops:Animation.Infinite
                NumberAnimation{
                    from: 0.0
                    to:1.0
                    duration:2500
                }

                PauseAnimation {
                    duration: 2000
                }
            }
        }
        visible: false
    }
    Blend {
        source: frameOverlay
        foregroundSource: mask
        mode: "lighten"
        anchors.fill: frameOverlay
        opacity:0.7
    }
}
