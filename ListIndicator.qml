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
    property alias innerLoaderColor: innerLoaderColorGradient.color
    property alias innerLoaderBackgroundColor: innerLoaderBackground.fillColor
    property alias outerBoxColor: outerBox.strokeColor
    property alias boxText: boxText.text
    property alias boxTextColor: boxText.color
    property alias seperatorColor: seperator.color

    property alias loadingBarsColor: loadingBars.color
    property alias loadingBarsSpacing: loadingBars.spacing
    property alias loadingBarsCount : loadingBars.barCount

    property color swipeTextColor: "white"

    property alias model: swipeViewRepeater.model
    required property list<string> sources
    required property list<color> valueImageColors
    property int value:0
    onValueChanged: {
        swipeView.currentIndex = value;
        if(valueImageColors.length)
            valueImageOverlay.color = valueImageColors[value];
        if(sources.length)
            valueImage.source = sources[value];
    }
    onSourcesChanged: {
        valueImage.source = sources[value];
    }
    onValueImageColorsChanged: {
        valueImageOverlay.color = valueImageColors[value];
    }

    function startAnimations(){
        outerRotatorAnimation.start()
        innerLoaderAnimation.start()
    }

    Rectangle {
        id: circle
        width: height // Ensures the circle is a perfect circle
        height: parent.height // Fills the height of the indicator
        radius: height / 2 // Makes it a circle
        color: "transparent" // Example color; change as needed
        border.width: 3
        anchors.left: parent.left // Aligns the circle to the left of the indicator
        SH.Shape {
            id:outerRotator
            opacity: 0.5
            z:parent.z-1
            antialiasing: true
            smooth: true
            anchors.centerIn: parent // Align the arcs to the center of the circle
            anchors.fill: parent
            SH.ShapePath {
                id: outerRotatorPath
                strokeColor: "black"
                fillColor:"transparent"
                strokeWidth: 7
                startX: width / 2
                startY: 0
                capStyle: SH.ShapePath.RoundCap
                PathAngleArc{
                    radiusX: outerRotator.width/2
                    radiusY: outerRotator.height/2
                    centerX: outerRotator.height/2
                    centerY: outerRotator.width/2
                    startAngle: 0
                    sweepAngle: 90
                }
                PathAngleArc{
                    radiusX: outerRotator.width/2
                    radiusY: outerRotator.height/2
                    centerX: outerRotator.height/2
                    centerY: outerRotator.width/2
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
        SH.Shape {
            visible : false
            enabled: false
            id:innerLoader
            antialiasing: true
            smooth: true
            anchors.centerIn: parent // Align the arcs to the center of the circle
            width:parent.width*3/4
            height:parent.height*3/4
            SH.ShapePath{
                strokeColor:"transparent"
                fillGradient: SH.ConicalGradient {
                        id: fillGradient
                        centerX: innerLoader.height/2
                        centerY: innerLoader.width/2
                        GradientStop {

                            id:innerLoaderColorGradient
                            position: 0
                            color: "black"
                        }
                        GradientStop {
                            position: 0.75
                            color: "transparent"
                        }
                    }
                startX: 0
                startY: 0
                capStyle: SH.ShapePath.SquareCap
                PathAngleArc{
                    radiusX: innerLoader.width/2
                    radiusY: innerLoader.height/2
                    centerX: innerLoader.height/2
                    centerY: innerLoader.width/2
                    startAngle: 0
                    sweepAngle: 360
                }
            }
            SH.ShapePath{
                id: innerLoaderBackground
                strokeColor:"transparent"
                fillColor: "white"
                startX: 0
                startY: 0
                capStyle: SH.ShapePath.SquareCap
                PathAngleArc{
                    radiusX: innerLoader.width/2-3
                    radiusY: innerLoader.height/2-3
                    centerX: innerLoader.height/2
                    centerY: innerLoader.width/2
                    startAngle: 0
                    sweepAngle: 360
                }
            }
            RotationAnimator {
                id:innerLoaderAnimation
                loops: Animation.Infinite
                target: innerLoader
                from: 0
                to: 360
                duration: 5000
                running: true
            }
        }

        Image  {
            id: valueImage
            width:{
                var r = circle.height - circle.border.width - 1
                var x = Math.sqrt(r*r/2)
                return x
            }
            height:width
            anchors.centerIn: parent
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            smooth:true
            visible:true
        }
        ColorOverlay{
            id: valueImageOverlay
            anchors.fill: valueImage
            source:valueImage
            antialiasing: true
            smooth:true
        }

    }
    SH.Shape {
        z:circle.z-1
        id: box
        antialiasing: true
        smooth: true
        anchors.fill: parent
        SH.ShapePath {
            id: outerBox
            fillColor: "transparent"
            strokeColor: "black"
            strokeWidth: 2
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
            strokeWidth: outerBox.strokeWidth + 2
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
    Rectangle{
        id: textHolder
        width:box.width-circle.width-swipeViewHolder.width/2
        height:box.height/2
        anchors.bottom:circle.bottom
        anchors.left:circle.right
        anchors.leftMargin: 5
        color:"transparent"
        Text{
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
                    padding:2
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
        property color color: "white"
        id: seperator
        anchors.top: circle.verticalCenter
        anchors.left: circle.right
        anchors.right: loadingBars.left
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        height: 5
        Rectangle{
            color: parent.color
            height:1
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
        }
        Rectangle{
            color: parent.color
            height:1
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
        }
    }
}

