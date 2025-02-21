import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

ApplicationWindow {
    property alias fuel : fuelSlider.value
    property alias battery : batterySlider.value
    property alias indoorTemp : indoorTempSlider.value
    property alias outdoorTemp : outdoorTempSlider.value
    property alias speed : speedSlider.value
    property int cameraStatus : 0
    property int lampsStatus : 0
    property int controlPanelCheck : 0
    property int radioSignalStrength : 0
    property int rotorSpeed : 0

    id: controlPanel
    width: 800
    height: 600
    title: "Control Panel"
    Material.theme: Material.Dark
    Material.accent: Material.Cyan
    visible: true
    flags: Qt.Dialog

    component CustomLabel : Label{
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: controlPanel.width < 800 ? Text.AlignLeft : Text.AlignHCenter
        height: parent.height
        font.bold: true
    }

    component Seperator : Rectangle{
        height: 1
        Layout.fillWidth: true
        gradient: Gradient{
            orientation: Gradient.Horizontal
            GradientStop{position: 0.0; color:"transparent";}
            GradientStop{position: 0.2; color:"white";}
            GradientStop{position: 0.8; color:"white";}
            GradientStop{position: 1.0; color:"transparent";}
        }
        opacity:0.9
        visible: controlPanel.width < 800
        Layout.margins: 14
    }

    ScrollView{
        id: scrollView
        anchors.fill: parent
        anchors.margins: 5
        GridLayout{
            columns: controlPanel.width < 800 ? 1 : 2
            rows: controlPanel.width < 800 ? 2 : 1
            columnSpacing: 15
            ColumnLayout{
                spacing: 5
                Layout.fillHeight: true
                Layout.fillWidth: true
                GridLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    columns: controlPanel.width < 330 ? 1 : 2
                    rows: controlPanel.width < 330 ? 2 : 1
                    CustomLabel{
                        text:"Fuel"
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    Slider{
                        id: fuelSlider
                        from: 0
                        to: 80
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                }
                GridLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    columns: controlPanel.width < 330 ? 1 : 2
                    rows: controlPanel.width < 330 ? 2 : 1
                    CustomLabel{
                        text:"Battery"
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    Slider{
                        id: batterySlider
                        from: 0
                        to: 100
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                }
                GridLayout{
                    columns: controlPanel.width < 330 ? 1 : 2
                    rows: controlPanel.width < 330 ? 2 : 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    CustomLabel{
                        text:"Cockpit\nTemperature"
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    Slider{
                        id: indoorTempSlider
                        from: -20
                        to: 80
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                }
                GridLayout{
                    columns: controlPanel.width < 330 ? 1 : 2
                    rows: controlPanel.width < 330 ? 2 : 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    CustomLabel{
                        text:"Outside\nTemperature"
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    Slider{
                        id: outdoorTempSlider
                        from: -20
                        to: 80
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                }
                GridLayout{
                    columns: controlPanel.width < 330 ? 1 : 2
                    rows: controlPanel.width < 330 ? 2 : 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    CustomLabel{
                        text:"Speed"
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    Slider{
                        id: speedSlider
                        from: 0
                        to: 220
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                }
            }
            ColumnLayout{
                spacing: 5
                Layout.fillHeight: true
                Layout.fillWidth: true
                Seperator{}

                GridLayout{
                    columns: controlPanel.width < 450 ? 1 : 4
                    rows: controlPanel.width < 450 ? 4 : 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    CustomLabel{
                        text:"Camera State"
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    RadioButton{
                        text:"Good"
                        checked : true
                        onCheckedChanged: {
                            if(checked)
                                controlPanel.cameraStatus = 0;
                        }
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    RadioButton{
                        text:"Warning"
                        onCheckedChanged: {
                            if(checked)
                                controlPanel.cameraStatus = 1;
                        }
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }

                    RadioButton{
                        text:"Error"
                        onCheckedChanged: {
                            if(checked)
                                controlPanel.cameraStatus = 2;
                        }
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                }

                Seperator{}

                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    CustomLabel{
                        text:"Lamps"
                    }
                    Switch{
                        checked: true
                        onCheckedChanged: {
                            if(checked)
                                controlPanel.lampsStatus = 0;
                            else
                                controlPanel.lampsStatus = 1;
                        }
                    }
                }

                Seperator{}

                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    CheckBox{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text:"Control Panel Check"
                        checked : true
                        onCheckedChanged:{
                            if(checked)
                                controlPanel.controlPanelCheck = 0
                            else
                                controlPanel.controlPanelCheck = 1
                        }
                    }
                }

                Seperator{}

                GridLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    columns: controlPanel.width < 450 ? 1 : 4
                    rows: controlPanel.width < 450 ? 4 : 1
                    CustomLabel{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text:"Radio Signal Strength"
                    }
                    RadioButton{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text:"Weak"
                        checked : true
                        onCheckedChanged: {
                            if (checked)
                                controlPanel.radioSignalStrength = 0;
                        }
                    }
                    RadioButton{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text:"Good"
                        onCheckedChanged: {
                            if (checked)
                                controlPanel.radioSignalStrength = 1;
                        }
                    }

                    RadioButton{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text:"Strong"
                        onCheckedChanged: {
                            if (checked)
                                controlPanel.radioSignalStrength = 2;
                        }
                    }
                }

                Seperator{}

                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    spacing: 10
                    CustomLabel{
                        text:"Rotor Speed"
                    }
                    Tumbler{
                        id: speedTumbler
                        model: ["Slowest","Slow","Medium","Fast","Fastest"]
                        currentIndex: 0
                        onCurrentIndexChanged: {
                            controlPanel.rotorSpeed = currentIndex
                        }
                        wrap: false
                    }
                }
            }
        }
    }
}
