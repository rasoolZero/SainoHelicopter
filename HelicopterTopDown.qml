import QtQuick
import Qt5Compat.GraphicalEffects


Item{

    property alias source : overlay.source
    property alias enabled : colorOverlay.visible
    property alias actualWidth: mainImage.implicitWidth

    Image{
        id: mainImage
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        antialiasing: true
        mipmap:true
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/top-down.png"
    }
    Image{
        id: overlay
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        antialiasing: true
        mipmap:true
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: "qrc:/assets/top-down.png"
        visible: false
    }
    ColorOverlay {
        id: colorOverlay
        anchors.fill: overlay
        source: overlay
        color: "#FF0000"
        SequentialAnimation on opacity{
            loops: Animation.Infinite
            NumberAnimation{
                from: 0
                to: 1
                duration:1000
                easing.type:Easing.Linear
            }
            PauseAnimation {
                duration: 100
            }
            NumberAnimation{
                from: 1
                to: 0
                duration:1000
                easing.type:Easing.Linear
            }
            PauseAnimation {
                duration: 100
            }
        }
    }
}
