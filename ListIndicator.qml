import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes as SH
import QtQuick.Controls
import QtQuick3D
import Qt5Compat.GraphicalEffects

Item {
    id : indicator
    property alias circleColor : circle.border.color
    property alias outerRotatorColor: outerRotatorPath.strokeColor
    property alias outerRotatorOpacity: outerRotator.opacity
    // property alias innerLoaderColor: innerLoaderColorGradient.color
    // property alias innerLoaderBackgroundColor: innerLoaderBackground.fillColor
    property alias outerBoxColor: outerBox.strokeColor
    property alias boxText: boxText.text
    property alias boxTextColor: boxText.color
    property color seperatorColor: white

    property alias loadingBarsColor: loadingBars.color
    property alias loadingBarsSpacing: loadingBars.spacing
    property alias loadingBarsCount : loadingBars.barCount

    property color swipeTextColor: "white"

    property alias model: swipeViewRepeater.model
    required property list<string> sources
    required property list<color> valueImageColors
    property alias value: swipeView.currentIndex
    property string currentSource: sources[value]
    property color currentColor: valueImageColors[value]
    property int thickness: height/25

    function startAnimations(){
        outerRotatorAnimation.start()
        // innerLoaderAnimation.start()
    }

    Rectangle {
        id: circle
        width: height // Ensures the circle is a perfect circle
        height: parent.height // Fills the height of the indicator
        radius: height / 2 // Makes it a circle
        color: "transparent" // Example color; change as needed
        border.width: indicator.thickness
        anchors.left: parent.left // Aligns the circle to the left of the indicator
        SH.Shape {
            id:outerRotator
            opacity: 0.5
            z:parent.z-1
            antialiasing: true
            smooth: false
            anchors.centerIn: parent // Align the arcs to the center of the circle
            anchors.fill: parent
            SH.ShapePath {
                id: outerRotatorPath
                strokeColor: "black"
                fillColor:"transparent"
                strokeWidth: indicator.thickness * 2
                startX: width / 2
                startY: 0
                capStyle: SH.ShapePath.RoundCap
                PathAngleArc{
                    radiusX: outerRotator.width/2
                    radiusY: outerRotator.height/2
                    centerX: outerRotator.width/2
                    centerY: outerRotator.height/2
                    startAngle: 0
                    sweepAngle: 90
                }
                PathAngleArc{
                    radiusX: outerRotator.width/2
                    radiusY: outerRotator.height/2
                    centerX: outerRotator.width/2
                    centerY: outerRotator.height/2
                    startAngle: 180
                    sweepAngle: 90
                }
            }
            RotationAnimator {
                id:outerRotatorAnimation
                loops: Animation.Infinite
                target: outerRotator
                from: 0
                to: 360
                duration: 10000
                running: true
            }
        }
        // SH.Shape {
        //     visible : false
        //     enabled: false
        //     id:innerLoader
        //     antialiasing: true
        //     smooth: false
        //     anchors.centerIn: parent // Align the arcs to the center of the circle
        //     width:parent.width - indicator.thickness * 5
        //     height:parent.height - indicator.thickness * 5
        //     SH.ShapePath{
        //         strokeColor:"transparent"
        //         fillGradient: SH.ConicalGradient {
        //                 id: fillGradient
        //                 centerX: innerLoader.width/2
        //                 centerY: innerLoader.height/2
        //                 GradientStop {

        //                     id:innerLoaderColorGradient
        //                     position: 0
        //                     color: "black"
        //                 }
        //                 GradientStop {
        //                     position: 0.75
        //                     color: "transparent"
        //                 }
        //             }
        //         startX: 0
        //         startY: 0
        //         capStyle: SH.ShapePath.SquareCap
        //         PathAngleArc{
        //             radiusX: innerLoader.width/2
        //             radiusY: innerLoader.height/2
        //             centerX: innerLoader.width/2
        //             centerY: innerLoader.height/2
        //             startAngle: 0
        //             sweepAngle: 360
        //         }
        //     }
        //     SH.ShapePath{
        //         id: innerLoaderBackground
        //         strokeColor:"transparent"
        //         fillColor: "white"
        //         startX: 0
        //         startY: 0
        //         capStyle: SH.ShapePath.SquareCap
        //         PathAngleArc{
        //             radiusX: innerLoader.width/2-indicator.thickness
        //             radiusY: innerLoader.height/2-indicator.thickness
        //             centerX: innerLoader.width/2
        //             centerY: innerLoader.height/2
        //             startAngle: 0
        //             sweepAngle: 360
        //         }
        //     }
        //     RotationAnimator {
        //         id:innerLoaderAnimation
        //         loops: Animation.Infinite
        //         target: innerLoader
        //         from: 0
        //         to: 360
        //         duration: 5000
        //         running: true
        //     }
        // }

        Item{
            id: valueImageHolder
            height:width
            anchors.centerIn: parent
            width:{
                var r = circle.height - circle.border.width - 1
                var x = Math.sqrt(r*r/2)
                return x
            }
            Repeater{
                model: indicator.model
                delegate: Image  {
                    required property int index
                    source : indicator.sources[index]
                    anchors.fill: valueImageHolder
                    antialiasing: true
                    fillMode: Image.PreserveAspectFit
                    smooth: false
                    visible:indicator.value === index
                    ColorOverlay{
                        id: valueImageOverlay
                        anchors.fill: parent
                        source:parent
                        color: indicator.currentColor
                        antialiasing: true
                        smooth: false
                    }
                }
            }
        }
    }
    SH.Shape {
        z:circle.z-1
        id: box
        antialiasing: true
        smooth: false
        anchors.fill: parent
        SH.ShapePath {
            id: outerBox
            fillColor: "transparent"
            strokeColor: "black"
            strokeWidth: Math.max(indicator.thickness / 2,2)
            startX:height/2
            startY:0
            capStyle:SH.ShapePath.SquareCap
            PathLine{x: box.width;}
            PathLine{y: box.height * 3 / 4; relativeX: 0;}
            PathLine{relativeX: -swipeViewHolder.width/4; relativeY:0}
            PathLine{relativeX: -swipeViewHolder.width/4; y:box.height}
            PathLine{x: box.height/2; relativeY: 0;}
            PathArc{
                relativeY:-box.height
                relativeX:0
                direction: PathArc.Clockwise
                radiusY: box.height/2
                radiusX: box.height/2
            }
        }
        SH.ShapePath {
            property int offset : height / 2

            id: outerBoxThickness
            fillColor: "transparent"
            strokeColor: outerBox.strokeColor
            strokeWidth: outerBox.strokeWidth * 1.5
            startX:height/2 + offset
            startY:0
            capStyle:SH.ShapePath.RoundCap
            PathLine{x: box.width - outerBoxThickness.offset;}
            PathMove{y: box.height/2 - 5; x: box.width;}
            PathLine{relativeY: box.height / 4 + 5; relativeX:0}
            PathLine{relativeX: -swipeViewHolder.width/4; relativeY:0}
            PathMove{relativeX: -swipeViewHolder.width/4; y:box.height}
            PathLine{x: box.height/2 + outerBoxThickness.offset; relativeY: 0;}
        }
    }
    Item{
        id: textHolder
        width:box.width-circle.width-swipeViewHolder.width/2
        height:box.height/2
        anchors.bottom:circle.bottom
        anchors.left:circle.right
        anchors.leftMargin: 5
        Text{
            textFormat: Text.PlainText
            id: boxText
            text: "Loading..."
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            minimumPointSize : 10
            font.pointSize: 72
        }
    }
    Item{
        id:swipeViewHolder
        SwipeView{
            currentIndex: indicator.value
            id: swipeView
            orientation: Qt.Horizontal
            interactive: false
            width:parent.width/3
            height:parent.height
            anchors.centerIn: parent
            Repeater{
            id: swipeViewRepeater
            delegate:Text{
                    required property string modelData
                    text:modelData
                    fontSizeMode:Text.Fit
                    font.pointSize: 72
                    color: indicator.swipeTextColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    opacity:SwipeView.isCurrentItem?1.0:0.3
                    visible: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                    padding:indicator.width/50
                }
            }
        }
        width: parent.width - circle.width - 20
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.right: parent.right
        anchors.top : parent.top
        height:parent.height/2 - 5
    }
    PulseLoader{
        id:loadingBars
        spacing: 1
        barCount : 7
        width: (swipeViewHolder.width / 4) - (barCount) * spacing - 5
        anchors.right: swipeViewHolder.right
        anchors.top : swipeViewHolder.bottom
        height:indicator.height/ 4
        running: true
        visible: minimumBarWidth >= 2
    }
    Item{
        id: seperator
        anchors.top: circle.verticalCenter
        anchors.left: circle.right
        anchors.right: loadingBars.visible ? loadingBars.left : indicator.right
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        height: 5
        Rectangle{
            color: indicator.seperatorColor
            height:1
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
        }
        Rectangle{
            color: indicator.seperatorColor
            height:1
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
        }
    }
}

