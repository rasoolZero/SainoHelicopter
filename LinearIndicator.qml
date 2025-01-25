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
    property alias innerLoaderColor: innerLoaderColorGradient.color
    property alias innerLoaderBackgroundColor: innerLoaderBackground.fillColor
    property alias valueColor: valueText.color
    property alias outerBoxColor: outerBox.strokeColor
    property alias boxText: boxText.text
    property alias boxTextColor: boxText.color
    property alias barsSpacing: barsLayout.spacing

    property color lowRangeColor : "black"
    required property color midRangeColor
    property color highRangeColor: "black"
    property int lowRangeThreshold: -999999
    property int highRangeThreshold: 999999

    property double disabledBarsOpacity : 0.3

    property int value
    required property int start
    required property int end
    property string postfix


    Rectangle {
        id: circle
        width: height // Ensures the circle is a perfect circle
        height: parent.height // Fills the height of the indicator
        radius: height / 2 // Makes it a circle
        color: "transparent" // Example color; change as needed
        border.width: 5
        anchors.left: parent.left // Aligns the circle to the left of the indicator
        SH.Shape {
            z:parent.z-1
            antialiasing: true
            smooth: true
            id:outerRotator
            anchors.centerIn: parent // Align the arcs to the center of the circle
            anchors.fill: parent
            SH.ShapePath {
                id: outerRotatorPath
                strokeColor: "black"
                fillColor:"transparent"
                strokeWidth: 6
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
                    radiusX: innerLoader.width/2-5
                    radiusY: innerLoader.height/2-5
                    centerX: innerLoader.height/2
                    centerY: innerLoader.width/2
                    startAngle: 0
                    sweepAngle: 360
                }
            }
            RotationAnimator {
                loops: Animation.Infinite
                target: innerLoader
                from: 0
                to: 360
                duration: 5000
                running: true
            }
        }

        Text {
            id: valueText
            text: indicator.value + indicator.postfix
            color: "black"
            font.pixelSize: parent.height/4
            anchors.centerIn: parent
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
            strokeWidth: 1.5
            startX:height/2
            startY:0
            capStyle:SH.ShapePath.SquareCap
            PathLine{x: box.width;}
            PathLine{y: box.height/2; relativeX: 0;}
            PathLine{relativeX: -barsLayout.width/4; relativeY:0}
            PathLine{relativeX: -barsLayout.width/4; y:box.height}
            PathLine{x: box.height/2; relativeY: 0;}
        }
    }
    Rectangle{
        id: textHolder
        width:box.width-circle.width-barsLayout.width/2
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
    RowLayout{
        id:barsLayout
        Repeater {
            id: bars
            model: indicator.end - indicator.start
            delegate: Rectangle {
                id: barsRectangle
                color: {
                    if((index+indicator.start) <= indicator.lowRangeThreshold)
                        return indicator.lowRangeColor
                    if((index+indicator.start) >= indicator.highRangeThreshold)
                        return indicator.highRangeColor
                    return indicator.midRangeColor
                }
                opacity: {
                    if((index+indicator.start) <= indicator.value)
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
}

