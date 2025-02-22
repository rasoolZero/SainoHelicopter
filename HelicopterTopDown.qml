import QtQuick
import Qt5Compat.GraphicalEffects


Item{

    property alias source : overlay.source
    property alias enabled : colorOverlay.visible
    property alias actualWidth: mainImage.implicitWidth
    property alias paintedWidth: mainImage.paintedWidth
    property alias overlayColor: colorOverlay.color
    readonly property int availableSpace : width - paintedWidth + paintedWidth * 0.5
    // onActualWidthChanged: {
    //     console.log("\nactualWidth:",actualWidth
    //                 ,"\npaintedWidth:",paintedWidth
    //                 ,"\n");
    // }
    // Rectangle{
    //     anchors.fill:parent
    //     color:"red"
    // }

    Image{
        id: mainImage
        anchors.fill: parent
        horizontalAlignment: Image.AlignLeft
        antialiasing: true
        mipmap:true
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: "qrc:/assets/top-down.png"
    }
    Image{
        id: overlay
        anchors.fill: mainImage
        horizontalAlignment: Image.AlignLeft
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
