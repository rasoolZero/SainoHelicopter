import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

ApplicationWindow {
    property alias fuel : fuelSlider.value
    property alias battery : batterySlider.value
    property alias indoorTemp : indoorTempSlider.value
    property alias outdoorTemp : outdoorTempSlider.value
    property alias speed : speedSlider.value
    property int cameraStatus : 0

    id: secondWindow
    width: 800
    height: 600
    title: "Control Panel"
    Material.theme: Material.Dark
    Material.accent: Material.Cyan
    visible: true
    flags: Qt.Dialog


    component CustomRow : Row{
        spacing: 10
    }
    component CustomLabel : Label{
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        height: parent.height
    }
    ScrollView{
        anchors.fill: parent
        CustomRow{
            anchors.margins: 15
            anchors.fill: parent
            Column{
                spacing: 5
                CustomRow{
                    CustomLabel{
                        text:"Fuel"
                    }
                    Slider{
                        id: fuelSlider
                        from: 0
                        to: 80
                    }
                }
                CustomRow{
                    CustomLabel{
                        text:"Battery"
                    }
                    Slider{
                        id: batterySlider
                        from: 0
                        to: 100
                    }
                }
                CustomRow{
                    CustomLabel{
                        text:"Cockpit\nTemperature"
                    }
                    Slider{
                        id: indoorTempSlider
                        from: -20
                        to: 80
                    }
                }
                CustomRow{
                    CustomLabel{
                        text:"Outside\nTemperature"
                    }
                    Slider{
                        id: outdoorTempSlider
                        from: -20
                        to: 80
                    }
                }
                CustomRow{
                    CustomLabel{
                        text:"Speed"
                    }
                    Slider{
                        id: speedSlider
                        from: 0
                        to: 220
                    }
                }
            }
            Column{
                spacing: 5
                CustomRow{
                    CustomLabel{
                        text:"Camera State"
                    }
                    RadioButton{
                        text:"Good"
                        checked : true
                        onCheckedChanged: {
                            if(checked)
                                controlPanel.cameraStatus = 0;
                        }
                    }
                    RadioButton{
                        text:"Warning"
                        onCheckedChanged: {
                            if(checked)
                                controlPanel.cameraStatus = 1;
                        }
                    }

                    RadioButton{
                        text:"Error"
                        onCheckedChanged: {
                            if(checked)
                                controlPanel.cameraStatus = 2;
                        }
                    }
                }
                CustomRow{
                    CustomLabel{
                        text:"Lamps"
                    }
                    Switch{
                    }
                }
                CustomRow{
                    CheckBox{
                        text:"Control Panel Check"
                    }
                }
                CustomRow{
                    CustomLabel{
                        text:"Radio Signal Strength"
                    }
                    RadioButton{
                        text:"Weak"
                        checked : true
                    }
                    RadioButton{
                        text:"Good"
                    }

                    RadioButton{
                        text:"Strong"
                    }
                }
                CustomRow{
                    CustomLabel{
                        text:"Rotor Speed"
                    }
                    Tumbler{
                        model: ["Slowest","Slow","Medium","Fast","Fastest"]
                        wrap: false
                    }
                }
            }
        }
    }
}
