
import QtQuick
import QtQuick.Window
import QtQuick.Controls.Material

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

    HelicopterTopDown {
        id: topDownView
        height: parent.height * 3/5
        width : parent.width * 3/4
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }

    TumblerSelector{
        id: selector
        anchors.top: parent.top
        anchors.right: parent.right
        height: parent.height
        width: parent.width*1/4
        onCurrentIndexChanged: {
            switch (currentIndex) {
                case 0:
                    topDownView.source = "assets/top-down.png";
                    topDownView.enabled = false
                    break;
                case 1:
                    topDownView.source = "assets/fuel.png";
                    topDownView.enabled = true
                    break;
                case 2:
                    topDownView.source = "assets/battery.png";
                    topDownView.enabled = true
                    break;
                case 3:
                    topDownView.source = "assets/cockpit.png";
                    topDownView.enabled = true
                    break;
                case 4:
                    topDownView.source = "assets/camera.png";
                    topDownView.enabled = true
                    break;
                case 5:
                    topDownView.source = "assets/top-down.png";
                    topDownView.enabled = true
                    break;
                case 6:
                    topDownView.source = "assets/lamps.png";
                    topDownView.enabled = true
                    break;
                case 7:
                    topDownView.source = "assets/rotor.png";
                    topDownView.enabled = true
                    break;
                case 8:
                    topDownView.source = "assets/control-panel.png";
                    topDownView.enabled = true
                    break;
                case 9:
                    topDownView.source = "assets/radio.png";
                    topDownView.enabled = true
                    break;
            }
        }
    }

    LinearIndicator{
        start:0
        end:100
        midRangeColor: "#37f7ff"
        lowRangeColor: "red"
        highRangeColor: "white"

        value:50
        barsSpacing: 0
        postfix: "%"
        boxText: "Battery Charge"
        boxTextColor: "white"
        innerLoaderBackgroundColor: window.color

        circleColor : "#37f7ff"
        outerRotatorColor: "#37f7ff"
        innerLoaderColor: "#37f7ff"
        valueColor: "#37f7ff"
        outerBoxColor: "#37f7ff"

        anchors.bottom: parent.bottom
        anchors.right: selector.left
        anchors.margins: 10
        width:topDownView.width - topDownView.actualWidth
        height:topDownView.height/4
    }

}
