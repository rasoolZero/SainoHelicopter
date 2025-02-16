import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick3D


Item {
    property alias frameColor : frameOverlay.color
    property alias text: text.text
    property alias textColor: text.color

    Image{
        id: frame
        source:"qrc:/assets/frame.svg"
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

    LinearGradient{
        id: mask
        anchors.fill: frameOverlay
        start:Qt.point(0,0)
        end:Qt.point(width*2,height)
        gradient: Gradient {
            id: maskGradient
            property real size : 0.02
            property real spread: 0.001
            property real position : 0.4
            GradientStop { position: 0.0; color: "transparent"}
            GradientStop { position: maskGradient.position - maskGradient.size / 2 - maskGradient.spread; color: "transparent"}
            GradientStop { position: maskGradient.position - maskGradient.size / 2; color: "white"}
            GradientStop { position: maskGradient.position + maskGradient.size / 2; color: "white"}
            GradientStop { position: maskGradient.position + maskGradient.size / 2 + maskGradient.spread; color: "transparent"}
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
