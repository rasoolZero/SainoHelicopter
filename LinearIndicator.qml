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
    property alias valueColor: valueText.color
    property alias outerBoxColor: outerBox.strokeColor
    property alias boxText: boxText.text
    property alias boxTextColor: boxText.color
    property alias barsSpacing: barsLayout.spacing
    property alias textOuterRotatorColor: textOuterRotatorPath.strokeColor
    property alias textOuterRotatorOpacity: textOuterRotator.opacity
    property color seperatorColor: "white"

    property alias loadingBarsColor: loadingBars.color
    property alias loadingBarsSpacing: loadingBars.spacing
    property alias loadingBarsCount : loadingBars.barCount

    property bool verticalFlip: false

    property color lowRangeColor : "black"
    required property color midRangeColor
    property color highRangeColor: "black"
    property int lowRangeThreshold: -999999
    property int highRangeThreshold: 999999

    property double disabledBarsOpacity : 0.3

    property int value
    required property int barsCount
    required property int start
    required property int end
    property string postfix
    property int thickness: height/25

    transform: Scale{   yScale: verticalFlip?-1:1
                        origin.x: indicator.width / 2
                        origin.y: indicator.height / 2
                    }

    function startAnimations(){
        outerRotatorAnimation.start()
        innerLoaderAnimation.start()
        textOuterRotatorAnimation.start()
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
                strokeWidth: indicator.thickness*2
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
                id: outerRotatorAnimation
                loops: Animation.Infinite
                target: outerRotator
                from: 0
                to: 360
                duration: 10000
                running: true
            }
        }
        SH.Shape {
            id:innerLoader
            antialiasing: true
            smooth: false
            anchors.centerIn: parent // Align the arcs to the center of the circle
            width:parent.width - indicator.thickness * 5
            height:parent.height - indicator.thickness * 5
            SH.ShapePath{
                strokeColor:"transparent"
                fillGradient: SH.ConicalGradient {
                        id: fillGradient
                        centerX: innerLoader.width/2
                        centerY: innerLoader.height/2
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
                    centerX: innerLoader.width/2
                    centerY: innerLoader.height/2
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
                    radiusX: innerLoader.width/2-indicator.thickness
                    radiusY: innerLoader.height/2-indicator.thickness
                    centerX: innerLoader.height/2
                    centerY: innerLoader.width/2
                    startAngle: 0
                    sweepAngle: 360
                }
            }
            RotationAnimator {
                id: innerLoaderAnimation
                loops: Animation.Infinite
                target: innerLoader
                from: 0
                to: 360
                duration: 5000
                running: true
            }
        }

        Text {
            textFormat: Text.PlainText
            id: valueText
            text: indicator.value + indicator.postfix
            color: "black"
            width:innerLoader.width/2
            height:innerLoader.height/2
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.Fit
            font.pixelSize: parent.height/4
            anchors.centerIn: parent
            transform: Scale{   yScale: indicator.verticalFlip?-1:1
                                origin.x: valueText.width / 2
                                origin.y: valueText.height / 2
                            }
        }
        SH.Shape {
            id:textOuterRotator
            opacity: 0.75
            antialiasing: true
            smooth: false
            anchors.centerIn: parent // Align the arcs to the center of the circle
            anchors.fill:innerLoader
            anchors.margins: indicator.thickness * 4
            SH.ShapePath {
                id: textOuterRotatorPath
                strokeColor: "black"
                fillColor:"transparent"
                strokeWidth: Math.max(indicator.thickness / 2,2)
                startX: width / 2
                startY: 0
                capStyle: SH.ShapePath.FlatCap
                PathAngleArc{
                    radiusX: textOuterRotator.width/2
                    radiusY: textOuterRotator.height/2
                    centerX: textOuterRotator.width/2
                    centerY: textOuterRotator.height/2
                    startAngle: 0
                    sweepAngle: 100
                }
                PathAngleArc{
                    radiusX: textOuterRotator.width/2
                    radiusY: textOuterRotator.height/2
                    centerX: textOuterRotator.width/2
                    centerY: textOuterRotator.height/2
                    startAngle: 120
                    sweepAngle: 100
                }
                PathAngleArc{
                    radiusX: textOuterRotator.width/2
                    radiusY: textOuterRotator.height/2
                    centerX: textOuterRotator.width/2
                    centerY: textOuterRotator.height/2
                    startAngle: 240
                    sweepAngle: 100
                }
            }
            RotationAnimator {
                id: textOuterRotatorAnimation
                loops: Animation.Infinite
                target: textOuterRotator
                from: 0
                to: 360
                duration: 10000
                running: true
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
            PathLine{y: box.height* 3 / 4; relativeX: 0;}
            PathLine{relativeX: -barsLayout.width/4; relativeY:0}
            PathLine{relativeX: -barsLayout.width/4; y:box.height}
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
            PathLine{relativeX: -barsLayout.width/4; relativeY:0}
            PathMove{relativeX: -barsLayout.width/4; y:box.height}
            PathLine{x: box.height/2 + outerBoxThickness.offset; relativeY: 0;}
        }
    }
    Item{
        id: textHolder
        width:box.width-circle.width-barsLayout.width/2
        height:box.height/2
        anchors.bottom:circle.bottom
        anchors.left:circle.right
        anchors.leftMargin: 8
        Text{
            textFormat: Text.PlainText
            id: boxText
            text: "Loading..."
            anchors.fill: textHolder
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            minimumPointSize : 10
            font.pointSize: 172
            transform: Scale{   yScale: indicator.verticalFlip?-1:1
                                origin.x: boxText.width / 2
                                origin.y: boxText.height / 2
                            }
        }
    }
    RowLayout{
        id:barsLayout
        Repeater {
            id: bars
            model: indicator.barsCount
            delegate: Rectangle {
                id: barsRectangle
                color: {
                    var oldValue = index;
                    var oldBottom = 0;
                    var oldTop = indicator.barsCount-1
                    var newTop = indicator.end
                    var newBottom = indicator.start
                    var newIndex = (oldValue - oldBottom) / (oldTop - oldBottom) * (newTop - newBottom) + newBottom
                    if(newIndex <= indicator.lowRangeThreshold)
                        return indicator.lowRangeColor
                    if(newIndex >= indicator.highRangeThreshold)
                        return indicator.highRangeColor
                    return indicator.midRangeColor
                }
                opacity: {
                    var oldValue = index;
                    var oldBottom = -1;
                    var oldTop = indicator.barsCount-1
                    var newTop = indicator.end
                    var newBottom = indicator.start
                    var newIndex = (oldValue - oldBottom) / (oldTop - oldBottom) * (newTop - newBottom) + newBottom
                    if(newIndex <= indicator.value)
                        return 1.0
                    else
                        return indicator.disabledBarsOpacity
                }
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
        spacing: 5
        width: parent.width - circle.width - 20
        anchors.right: parent.right
        anchors.top : parent.top
        anchors.margins: 10
        height:parent.height/2 - anchors.margins*2
        uniformCellSizes: true
    }

    PulseLoader{
        id:loadingBars
        spacing: 1
        barCount : 7
        width: (barsLayout.width / 4) - (barCount) * spacing - 5
        anchors.right: barsLayout.right
        anchors.top : barsLayout.bottom
        anchors.topMargin: 5
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
