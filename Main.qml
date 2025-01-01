
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

ApplicationWindow {
    id: window
    minimumWidth : 1000
    maximumWidth : 1000
    minimumHeight : 600
    maximumHeight : 600
    visible: true
    color: "#202020"

    HelicopterView{
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width*3/4
        height: parent.height*2/5
        bgColor: "#202020"
        copterColor: "white"
        id : view
    }
    Item{
        height: parent.height*3/5
        width : parent.width * 3/4
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        Image{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            source: "assets/top-down.png"
        }
        Image{
            id: overlay
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            smooth: true
            source: "assets/rotor.png"
            visible: false
        }
        ColorOverlay {
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
}
