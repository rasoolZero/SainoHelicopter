
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material

ApplicationWindow {
    id: window
    minimumWidth : 1000
    maximumWidth : 1000
    minimumHeight : 600
    maximumHeight : 600
    visible: true
    color: "#202020"
    title: "Saino Helicopter"

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
        anchors.leftMargin: 10
    }

    TumblerSelector{
        id: selector
        anchors.top: parent.top
        anchors.right: parent.right
        height: parent.height
        width: parent.width*1/4
        onCurrentIndexChanged: {

            let elements = [insideTempIndicator, outsideTempIndicator, batteryIndicator
                            , fuelIndicator, speedIndicator, lampsIndicator, cameraIndicator
                            , controlPanelIndicator, radioIndicator, rotorSpeedIndicator, description];


            for (let i = 0; i < elements.length; i++) {
                elements[i].visible = false;
            }

            switch (currentIndex) {
                case 0:
                    topDownView.source = "assets/top-down.png";
                    topDownView.enabled = false
                    description.visible = true
                    break;
                case 1:
                    topDownView.source = "assets/fuel.png";
                    topDownView.enabled = true
                    fuelIndicator.visible = true;
                    break;
                case 2:
                    topDownView.source = "assets/battery.png";
                    topDownView.enabled = true
                    batteryIndicator.visible = true;
                    break;
                case 3:
                    topDownView.source = "assets/cockpit.png";
                    topDownView.enabled = true
                    insideTempIndicator.visible = outsideTempIndicator.visible = true;
                    break;
                case 4:
                    topDownView.source = "assets/camera.png";
                    topDownView.enabled = true
                    cameraIndicator.visible = true
                    break;
                case 5:
                    topDownView.source = "assets/top-down.png";
                    topDownView.enabled = true
                    speedIndicator.visible = true
                    break;
                case 6:
                    topDownView.source = "assets/lamps.png";
                    topDownView.enabled = true
                    lampsIndicator.visible = true
                    break;
                case 7:
                    topDownView.source = "assets/rotor.png";
                    topDownView.enabled = true
                    rotorSpeedIndicator.visible = true
                    break;
                case 8:
                    topDownView.source = "assets/control-panel.png";
                    topDownView.enabled = true
                    controlPanelIndicator.visible = true
                    break;
                case 9:
                    topDownView.source = "assets/radio.png";
                    topDownView.enabled = true
                    radioIndicator.visible = true
                    break;
            }
        }
    }

    LinearIndicator{
        id:batteryIndicator
        start:0
        end:100
        midRangeColor: "#37f7ff"

        value : controlPanel.battery
        barsCount: 20
        barsSpacing: 5
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
        width:(topDownView.width - topDownView.actualWidth)*1.5
        height:topDownView.height/4

        visible: false

    }
    LinearIndicator{
        id:fuelIndicator
        start:0
        end:80
        midRangeColor: "#37f7ff"

        value:controlPanel.fuel
        barsCount: 40
        barsSpacing: 2
        postfix: " Gal"
        boxText: "Fuel"
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
        width:(topDownView.width - topDownView.actualWidth)*1.5
        height:topDownView.height/4

        visible: false

    }

    LinearIndicator{
        id:speedIndicator
        start:0
        end:220
        midRangeColor: "#37f7ff"

        value:controlPanel.speed
        barsCount: 100
        barsSpacing: 0
        postfix: " KPH"
        boxText: "Airspeed"
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
        width:(topDownView.width - topDownView.actualWidth)*1.5
        height:topDownView.height/4

        visible: false

    }

    LinearIndicator{
        id:insideTempIndicator
        start:-20
        end:80
        lowRangeThreshold: 0
        highRangeThreshold: 60
        midRangeColor: "#ff9e37"
        highRangeColor: "#ff3a37"
        lowRangeColor: "#37f7ff"

        value : controlPanel.indoorTemp
        barsCount: 100
        barsSpacing: 0
        postfix: "°"
        boxText: "Cockpit Temperature"
        boxTextColor: "white"
        innerLoaderBackgroundColor: window.color

        circleColor : "#37f7ff"
        outerRotatorColor: "#ff9e37"
        innerLoaderColor: "#ff3a37"
        valueColor: "#37f7ff"
        outerBoxColor: "#37f7ff"

        anchors.bottom: parent.bottom
        anchors.right: selector.left
        anchors.margins: 10
        width:(topDownView.width - topDownView.actualWidth)*1.5
        height:topDownView.height/4

        visible: false
    }

    LinearIndicator{
        id:outsideTempIndicator
        start:-20
        end:80
        lowRangeThreshold: 0
        highRangeThreshold: 60
        midRangeColor: "#ff9e37"
        highRangeColor: "#ff3a37"
        lowRangeColor: "#37f7ff"

        value : controlPanel.outdoorTemp
        barsCount: 100
        barsSpacing: 0
        postfix: "°"
        boxText: "Outside Temperature"
        boxTextColor: "white"
        innerLoaderBackgroundColor: window.color

        circleColor : "#37f7ff"
        outerRotatorColor: "#ff9e37"
        innerLoaderColor: "#ff3a37"
        valueColor: "#37f7ff"
        outerBoxColor: "#37f7ff"

        anchors.top: topDownView.top
        anchors.right: selector.left
        anchors.margins: 10
        width:(topDownView.width - topDownView.actualWidth)*1.5
        height:topDownView.height/4

        verticalFlip: true

        visible: false
    }


    ListIndicator{
        id:lampsIndicator

        value:controlPanel.lampsStatus
        boxText: "Lamps"
        boxTextColor: "white"
        swipeTextColor: "white"
        innerLoaderBackgroundColor: window.color


        circleColor : "#37f7ff"
        outerRotatorColor: "#37f7ff"
        innerLoaderColor: "#37f7ff"
        outerBoxColor: "#37f7ff"

        anchors.bottom: parent.bottom
        anchors.right: selector.left
        anchors.margins: 10
        width:(topDownView.width - topDownView.actualWidth)*1.5
        height:topDownView.height/4

        model: ["On","Off"]
        sources: ["assets/lamp-on.svg","assets/lamp-off.svg"]
        valueImageColors: ["#ffd037","white"]

        visible: false
    }

    ListIndicator{
        id:cameraIndicator

        value:controlPanel.cameraStatus
        boxText: "Fixed Camera"
        boxTextColor: "white"
        swipeTextColor: "white"
        innerLoaderBackgroundColor: window.color


        circleColor : "#37f7ff"
        outerRotatorColor: "#37f7ff"
        innerLoaderColor: "#37f7ff"
        outerBoxColor: "#37f7ff"

        anchors.bottom: parent.bottom
        anchors.right: selector.left
        anchors.margins: 10
        width:(topDownView.width - topDownView.actualWidth)*1.5
        height:topDownView.height/4

        model: ["Good","Warning","Error"]
        sources: ["assets/ok.svg","assets/warning.svg","assets/error.svg"]
        valueImageColors: ["#37f7ff","#ffd037","#ff3a37"]

        visible: false
    }
    ListIndicator{
        id:controlPanelIndicator

        value:controlPanel.controlPanelCheck
        boxText: "Control Panel Check"
        boxTextColor: "white"
        swipeTextColor: "white"
        innerLoaderBackgroundColor: window.color


        circleColor : "#37f7ff"
        outerRotatorColor: "#37f7ff"
        innerLoaderColor: "#37f7ff"
        outerBoxColor: "#37f7ff"

        anchors.bottom: parent.bottom
        anchors.right: selector.left
        anchors.margins: 10
        width:(topDownView.width - topDownView.actualWidth)*1.5
        height:topDownView.height/4

        model: ["Pass","Fail"]
        sources: ["assets/ok.svg","assets/error.svg"]
        valueImageColors: ["#37f7ff","#ff3a37"]

        visible: false
    }
    ListIndicator{
        id:radioIndicator

        value:0
        boxText: "Radio Signal"
        boxTextColor: "white"
        swipeTextColor: "white"
        innerLoaderBackgroundColor: window.color


        circleColor : "#37f7ff"
        outerRotatorColor: "#37f7ff"
        innerLoaderColor: "#37f7ff"
        outerBoxColor: "#37f7ff"

        anchors.bottom: parent.bottom
        anchors.right: selector.left
        anchors.margins: 10
        width:(topDownView.width - topDownView.actualWidth)*1.5
        height:topDownView.height/4

        model: ["Weak","Good","Strong"]
        sources: ["assets/signal-weak.svg","assets/signal-good.svg","assets/signal-good.svg"]
        valueImageColors: ["#ff3a37","#ffd037","#37f7ff"]

        visible: false
    }
    ListIndicator{
        id:rotorSpeedIndicator

        value:0
        boxText: "Main Rotor Speed"
        boxTextColor: "white"
        swipeTextColor: "white"
        innerLoaderBackgroundColor: window.color

        circleColor : "#37f7ff"
        outerRotatorColor: "#37f7ff"
        innerLoaderColor: "#37f7ff"
        outerBoxColor: "#37f7ff"

        anchors.bottom: parent.bottom
        anchors.right: selector.left
        anchors.margins: 10
        width:(topDownView.width - topDownView.actualWidth)*1.5
        height:topDownView.height/4

        model: ["Slowest","Slow","Medium","Fast","Fastest"]
        sources: ["assets/gauge-min.svg","assets/gauge-low.svg","assets/gauge-middle.svg","assets/gauge-high.svg","assets/gauge-max.svg"]
        valueImageColors: ["#ffffff","#ffffff","#ffffff","#ffffff","#ffffff"]

        visible: false
    }

    TextDisplay{
        id: description
        width:(topDownView.width - topDownView.actualWidth)
        height:topDownView.height
        frameColor: "#37f7ff"
        anchors.bottom: parent.bottom
        anchors.right: topDownView.right
        opacity: 0.85
        text: "The Apache AH-64 is an advanced attack helicopter manufactured by Boeing (originally by Hughes Helicopters). First produced in 1983, it features superior air resistance with a streamlined fuselage and rotor design. It has a maximum altitude of approximately 21,000 feet (6,400 meters), making it highly effective in diverse combat environments."
        textColor: "white"
    }

    Item{
        anchors.fill: parent
        focus: !controlPanel.visible
        Keys.onSpacePressed: {
                controlPanel.show();
        }
    }

    ControlPanel{
        Material.theme: Material.Dark
        Material.accent: Material.Cyan
        id : controlPanel
        opacity: 0.95
        visible: false

    }
}
