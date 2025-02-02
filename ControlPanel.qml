import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

ApplicationWindow {
    id: secondWindow
    width: 800
    height: 600
    title: "Control Panel"
    Material.theme: Material.Dark
    Material.accent: Material.Cyan
    visible: true

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
                        from: 0
                        to: 80
                    }
                }
                CustomRow{
                    CustomLabel{
                        text:"Battery"
                    }
                    Slider{
                        from: 0
                        to: 100
                    }
                }
                CustomRow{
                    CustomLabel{
                        text:"Cockpit\nTemperature"
                    }
                    Slider{
                        from: -20
                        to: 80
                    }
                }
                CustomRow{
                    CustomLabel{
                        text:"Outside\nTemperature"
                    }
                    Slider{
                        from: -20
                        to: 80
                    }
                }
                CustomRow{
                    CustomLabel{
                        text:"Speed"
                    }
                    Slider{
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
                    }
                    RadioButton{
                        text:"Warning"
                    }

                    RadioButton{
                        text:"Error"
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
