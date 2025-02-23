import QtQuick.Layouts
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects
import QtCore

ApplicationWindow {
    id: window

    minimumHeight: 500
    minimumWidth: 800
    height: 600
    width: 1000
    visible: true
    readonly property real aspectRatio: width/height
    readonly property real lanscapeThreshold: 1.9

    QtObject {
        id: colorConfig
        property color backgroundColor : "#1c1b1f"
        property color accentColor : "#80deea"
        property color warningColor : "#FFC444"
        property color errorColor : "#FF5244"
        property color okColor : "#3AD755"
        property color textColor : "#ffffff"
        property color scanlineColor: okColor
    }

    color: colorConfig.backgroundColor
    title: "Saino Helicopter"

    Item{
        id:view
        HelicopterView{
            copterColor: "white"
            anchors.fill: view
            id : viewMain
        }

        LinearGradient{
            id: mask
            anchors.fill: viewMain
            gradient: Gradient {
                id: maskGradient
                property real size : 0.035
                property real spread: 0.002
                property real position : 0.4
                GradientStop { position: 0.0; color: "transparent"}
                GradientStop { position: maskGradient.position - maskGradient.size / 2 - maskGradient.spread; color: "transparent"}
                GradientStop { position: maskGradient.position - maskGradient.size / 2; color: "green"}
                GradientStop { position: maskGradient.position + maskGradient.size / 2; color: "green"}
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
                        duration: 500
                    }
                    NumberAnimation{
                        from: 1.0
                        to:0.0
                        duration:2500
                    }
                    PauseAnimation {
                        duration: 500
                    }
                }
            }
            visible: false
        }
        Blend {
            source: viewMain
            foregroundSource: mask
            mode: "hardLight"
            anchors.fill: viewMain
            opacity:1
        }
    }


    TumblerSelector{
        id: selector
        hideText: !mainLayout.visible
        textColor: colorConfig.textColor
        separatorColor: colorConfig.okColor
        onCurrentIndexChanged: {

            let elements = [insideTempIndicator, outsideTempIndicator, batteryIndicator
                            , fuelIndicator, speedIndicator, lampsIndicator, cameraIndicator
                            , controlPanelIndicator, radioIndicator, rotorSpeedIndicator, description];


            for (let i = 0; i < elements.length; i++) {
                elements[i].visible = false;
            }

            switch (currentIndex) {
                case 0:
                    topDownView.source = "qrc:/assets/top-down.png";
                    topDownView.enabled = false
                    description.visible = true
                    break;
                case 1:
                    topDownView.source = "qrc:/assets/fuel.png";
                    topDownView.enabled = true
                    fuelIndicator.visible = true;
                    break;
                case 2:
                    topDownView.source = "qrc:/assets/battery.png";
                    topDownView.enabled = true
                    batteryIndicator.visible = true;
                    break;
                case 3:
                    topDownView.source = "qrc:/assets/cockpit.png";
                    topDownView.enabled = true
                    insideTempIndicator.visible = outsideTempIndicator.visible = true;
                    break;
                case 4:
                    topDownView.source = "qrc:/assets/camera.png";
                    topDownView.enabled = true
                    cameraIndicator.visible = true
                    break;
                case 5:
                    topDownView.source = "qrc:/assets/top-down.png";
                    topDownView.enabled = true
                    speedIndicator.visible = true
                    break;
                case 6:
                    topDownView.source = "qrc:/assets/lamps.png";
                    topDownView.enabled = true
                    lampsIndicator.visible = true
                    break;
                case 7:
                    topDownView.source = "qrc:/assets/rotor.png";
                    topDownView.enabled = true
                    rotorSpeedIndicator.visible = true
                    break;
                case 8:
                    topDownView.source = "qrc:/assets/control-panel.png";
                    topDownView.enabled = true
                    controlPanelIndicator.visible = true
                    break;
                case 9:
                    topDownView.source = "qrc:/assets/radio.png";
                    topDownView.enabled = true
                    radioIndicator.visible = true
                    break;
            }
        }
    }

    Item{
        id: details
        HelicopterTopDown {
            id: topDownView
            overlayColor : colorConfig.errorColor
            anchors.fill: details
            visible: !mainLayout.visible ? !description.visible : true
        }

        LinearIndicator{
            id:batteryIndicator
            start:0
            end:100
            midRangeColor: colorConfig.accentColor

            value : controlPanel.battery
            barsCount: 20
            barsSpacing: 5
            postfix: "%"
            boxText: "Battery Charge"
            boxTextColor: colorConfig.textColor
            innerLoaderBackgroundColor: window.color

            circleColor : colorConfig.accentColor
            outerRotatorColor: colorConfig.accentColor
            innerLoaderColor: colorConfig.accentColor
            valueColor: colorConfig.accentColor
            outerBoxColor: colorConfig.accentColor
            loadingBarsColor: colorConfig.accentColor
            seperatorColor: colorConfig.accentColor

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            width: Math.min(topDownView.availableSpace,height * 4)
            height:topDownView.height * (150/460)
            visible: false

        }
        LinearIndicator{
            id:fuelIndicator
            start:0
            end:80
            midRangeColor: colorConfig.accentColor

            value:controlPanel.fuel
            barsCount: 40
            barsSpacing: 2
            postfix: " Gal"
            boxText: "Fuel"
            boxTextColor: colorConfig.textColor
            innerLoaderBackgroundColor: window.color

            circleColor : colorConfig.accentColor
            outerRotatorColor: colorConfig.accentColor
            innerLoaderColor: colorConfig.accentColor
            valueColor: colorConfig.accentColor
            outerBoxColor: colorConfig.accentColor
            loadingBarsColor: colorConfig.accentColor
            seperatorColor: colorConfig.accentColor

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            width: Math.min(topDownView.availableSpace,height * 4)
            height:topDownView.height * (150/460)

            visible: false

        }

        LinearIndicator{
            id:speedIndicator
            start:0
            end:220
            midRangeColor: colorConfig.accentColor

            value:controlPanel.speed
            barsCount: 100
            barsSpacing: 0
            postfix: " KPH"
            boxText: "Airspeed"
            boxTextColor: colorConfig.textColor
            innerLoaderBackgroundColor: window.color

            circleColor : colorConfig.accentColor
            outerRotatorColor: colorConfig.accentColor
            innerLoaderColor: colorConfig.accentColor
            valueColor: colorConfig.accentColor
            outerBoxColor: colorConfig.accentColor
            loadingBarsColor: colorConfig.accentColor
            seperatorColor: colorConfig.accentColor

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            width: Math.min(topDownView.availableSpace,height * 4)
            height:topDownView.height * (150/460)

            visible: false

        }

        LinearIndicator{
            id:insideTempIndicator
            start:-20
            end:80
            lowRangeThreshold: 0
            highRangeThreshold: 60
            midRangeColor: colorConfig.warningColor
            highRangeColor: colorConfig.errorColor
            lowRangeColor: colorConfig.accentColor

            value : controlPanel.indoorTemp
            barsCount: 100
            barsSpacing: 0
            postfix: "°"
            boxText: "Cockpit Temperature"
            boxTextColor: colorConfig.textColor
            innerLoaderBackgroundColor: window.color

            circleColor : colorConfig.accentColor
            outerRotatorColor: colorConfig.warningColor
            innerLoaderColor: colorConfig.errorColor
            valueColor: colorConfig.accentColor
            outerBoxColor: colorConfig.accentColor
            loadingBarsColor: colorConfig.accentColor
            seperatorColor: colorConfig.accentColor

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            width: Math.min(topDownView.availableSpace,height * 4)
            height:topDownView.height * (150/460)

            visible: false
        }

        LinearIndicator{
            id:outsideTempIndicator
            start:-20
            end:80
            lowRangeThreshold: 0
            highRangeThreshold: 60
            midRangeColor: colorConfig.warningColor
            highRangeColor: colorConfig.errorColor
            lowRangeColor: colorConfig.accentColor

            value : controlPanel.outdoorTemp
            barsCount: 100
            barsSpacing: 0
            postfix: "°"
            boxText: "Outside Temperature"
            boxTextColor: colorConfig.textColor
            innerLoaderBackgroundColor: window.color

            circleColor : colorConfig.accentColor
            outerRotatorColor: colorConfig.warningColor
            innerLoaderColor: colorConfig.errorColor
            valueColor: colorConfig.accentColor
            outerBoxColor: colorConfig.accentColor
            loadingBarsColor: colorConfig.accentColor
            seperatorColor: colorConfig.accentColor

            anchors.top: topDownView.top
            anchors.right: parent.right
            anchors.margins: 10
            width: Math.min(topDownView.availableSpace,height * 4)
            height:topDownView.height * (150/460)

            verticalFlip: true

            visible: false
        }

        ListIndicator{
            id:lampsIndicator

            value:controlPanel.lampsStatus
            boxText: "Lamps"
            boxTextColor: colorConfig.textColor
            swipeTextColor: colorConfig.textColor
            innerLoaderBackgroundColor: window.color
            loadingBarsColor: colorConfig.accentColor

            circleColor : colorConfig.accentColor
            outerRotatorColor: colorConfig.accentColor
            innerLoaderColor: colorConfig.accentColor
            outerBoxColor: colorConfig.accentColor
            seperatorColor: colorConfig.accentColor

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            width: Math.min(topDownView.availableSpace,height * 4)
            height:topDownView.height * (150/460)

            model: ["On","Off"]
            sources: ["qrc:/assets/lamp-on.svg","qrc:/assets/lamp-off.svg"]
            valueImageColors: [colorConfig.warningColor,"white"]

            visible: false
        }

        ListIndicator{
            id:cameraIndicator

            value:controlPanel.cameraStatus
            boxText: "Fixed Camera"
            boxTextColor: colorConfig.textColor
            swipeTextColor: colorConfig.textColor
            innerLoaderBackgroundColor: window.color


            circleColor : colorConfig.accentColor
            outerRotatorColor: colorConfig.accentColor
            innerLoaderColor: colorConfig.accentColor
            outerBoxColor: colorConfig.accentColor
            loadingBarsColor: colorConfig.accentColor
            seperatorColor: colorConfig.accentColor

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            width: Math.min(topDownView.availableSpace,height * 4)
            height:topDownView.height * (150/460)

            model: ["Good","Warning","Error"]
            sources: ["qrc:/assets/ok.svg","qrc:/assets/warning.svg","qrc:/assets/error.svg"]
            valueImageColors: [colorConfig.okColor,colorConfig.warningColor,colorConfig.errorColor]

            visible: false
        }
        ListIndicator{
            id:controlPanelIndicator

            value:controlPanel.controlPanelCheck
            boxText: "Control Panel Check"
            boxTextColor: colorConfig.textColor
            swipeTextColor: colorConfig.textColor
            innerLoaderBackgroundColor: window.color


            circleColor : colorConfig.accentColor
            outerRotatorColor: colorConfig.accentColor
            innerLoaderColor: colorConfig.accentColor
            outerBoxColor: colorConfig.accentColor
            loadingBarsColor: colorConfig.accentColor
            seperatorColor: colorConfig.accentColor

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            width: Math.min(topDownView.availableSpace,height * 4)
            height:topDownView.height * (150/460)

            model: ["Pass","Fail"]
            sources: ["qrc:/assets/ok.svg","qrc:/assets/error.svg"]
            valueImageColors: [colorConfig.okColor,colorConfig.errorColor]

            visible: false
        }
        ListIndicator{
            id:radioIndicator

            value:controlPanel.radioSignalStrength
            boxText: "Radio Signal"
            boxTextColor: colorConfig.textColor
            swipeTextColor: colorConfig.textColor
            innerLoaderBackgroundColor: window.color


            circleColor : colorConfig.accentColor
            outerRotatorColor: colorConfig.accentColor
            innerLoaderColor: colorConfig.accentColor
            outerBoxColor: colorConfig.accentColor
            loadingBarsColor: colorConfig.accentColor
            seperatorColor: colorConfig.accentColor

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            width: Math.min(topDownView.availableSpace,height * 4)
            height:topDownView.height * (150/460)

            model: ["Weak","Good","Strong"]
            sources: ["qrc:/assets/signal-weak.svg","qrc:/assets/signal-good.svg","qrc:/assets/signal-strong.svg"]
            valueImageColors: [colorConfig.errorColor,colorConfig.warningColor,colorConfig.okColor]

            visible: false
        }
        ListIndicator{
            id:rotorSpeedIndicator

            value:controlPanel.rotorSpeed
            boxText: "Main Rotor Speed"
            boxTextColor: colorConfig.textColor
            swipeTextColor: colorConfig.textColor
            innerLoaderBackgroundColor: window.color

            circleColor : colorConfig.accentColor
            outerRotatorColor: colorConfig.accentColor
            innerLoaderColor: colorConfig.accentColor
            outerBoxColor: colorConfig.accentColor
            loadingBarsColor: colorConfig.accentColor
            seperatorColor: colorConfig.accentColor

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            width: Math.min(topDownView.availableSpace,height * 4)
            height:topDownView.height * (150/460)

            model: ["Slowest","Slow","Medium","Fast","Fastest"]
            sources: ["qrc:/assets/gauge-min.svg","qrc:/assets/gauge-low.svg","qrc:/assets/gauge-middle.svg","qrc:/assets/gauge-high.svg","qrc:/assets/gauge-max.svg"]
            valueImageColors: ["#ffffff","#ffffff","#ffffff","#ffffff","#ffffff"]

            visible: false
        }

        TextDisplay{
            id: description
            readonly property bool full : !mainLayout.visible
            readonly property int offset : full ? (parent.width) / 10 : 0
            width: full ? parent.width - offset * 2 : height*(300/350)
            height: topDownView.height - offset * 2
            frameColor: mainLayout.visible ? colorConfig.accentColor : colorConfig.warningColor
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: offset
            opacity: 0.85
            backgroundColor: colorConfig.backgroundColor
            text: "The Apache AH-64 is an advanced attack helicopter manufactured by Boeing (originally by Hughes Helicopters). First produced in 1983, it features superior air resistance with a streamlined fuselage and rotor design. It has a maximum altitude of approximately 21,000 feet (6,400 meters), making it highly effective in diverse combat environments."
            textColor: colorConfig.textColor
        }
    }
    Item{
        anchors.fill: parent
        focus: !controlPanel.visible
        Keys.onSpacePressed: {
                controlPanel.show();
        }
        Keys.onUpPressed: {
            selector.currentIndex = (selector.currentIndex === 0) ? selector.model.count-1 : selector.currentIndex - 1;
            selector.positionViewAtIndex(selector.currentIndex,Tumbler.Center);
        }
        Keys.onDownPressed: {
            selector.currentIndex = (selector.currentIndex === selector.model.count - 1) ? 0 : selector.currentIndex + 1;
            selector.positionViewAtIndex(selector.currentIndex,Tumbler.Center);
        }
    }

    ControlPanel{
        Material.theme: Material.Dark
        Material.accent: Material.Cyan
        id : controlPanel
        opacity: 0.92
        visible: false

    }

    FirstRunInfo{
        id: firstRunInfoDialog
        width:300
        height:400

        Settings{
            id:settings
            property bool firstTimeRun: true
        }

        Component.onCompleted: {
            if (settings.firstTimeRun) {
                firstRunInfoDialog.show();
                settings.firstTimeRun = false;
            }
        }
    }

    GridLayout{
        id:mainLayout
        rows:2
        columns:2
        anchors.fill:parent
        LayoutItemProxy{
            target:view
            Layout.row: 0
            Layout.column: 0
            Layout.maximumHeight: window.height * (2 / 5)
            Layout.maximumWidth: window.width * (3 / 4)
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        LayoutItemProxy{
            target:details
            Layout.row: 1
            Layout.column: 0
            Layout.leftMargin: 5
            Layout.maximumHeight: window.height * (3 / 5)
            Layout.maximumWidth: window.width * (3 / 4)
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        LayoutItemProxy{
            target:selector
            Layout.row: 0
            Layout.column: 1
            Layout.rowSpan: 2
            Layout.maximumHeight: window.height
            Layout.maximumWidth: window.width * (1 / 4)
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        visible: true
    }

    GridLayout{
        id:landscapeLayout
        rows:1
        columns:2
        anchors.fill:parent
        Item{
            Layout.column: 0
            Layout.maximumHeight: window.height
            Layout.maximumWidth: window.width * (4 / 5)
            Layout.fillHeight: true
            Layout.fillWidth: true
            SwipeView{
                id:lanscapeSwipeView
                anchors.fill:parent
                LayoutItemProxy{
                    target:view
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    visible: SwipeView.isCurrentItem
                }
                LayoutItemProxy{
                    target:details
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    visible: SwipeView.isCurrentItem
                }
            }
            PageIndicator {
                Material.theme: Material.Dark
                Material.accent: Material.Cyan
                id: indicator

                count: lanscapeSwipeView.count
                currentIndex: lanscapeSwipeView.currentIndex

                anchors.bottom: lanscapeSwipeView.bottom
                anchors.horizontalCenter: lanscapeSwipeView.horizontalCenter
            }
        }
        LayoutItemProxy{
            target:selector
            Layout.column: 1
            Layout.maximumHeight: window.height
            Layout.maximumWidth: window.width * (1 / 5)
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        visible: false
    }


    onAspectRatioChanged:{
        if(aspectRatio > lanscapeThreshold){
            mainLayout.visible = false;
            landscapeLayout.visible = true;
        }
        else{
            mainLayout.visible = true;
            landscapeLayout.visible = false;
        }
        let elements = [insideTempIndicator, outsideTempIndicator, batteryIndicator
                        , fuelIndicator, speedIndicator, lampsIndicator, cameraIndicator
                        , controlPanelIndicator, radioIndicator, rotorSpeedIndicator];

        for (let i = 0; i < elements.length; i++) {
            elements[i].startAnimations()
        }

        // console.log(aspectRatio)
    }
}
