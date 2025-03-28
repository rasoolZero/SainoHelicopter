
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

ApplicationWindow  {
    Material.theme: Material.Dark
    Material.accent: Material.Cyan
    id: root

    title: "Welcome!"

    flags: Qt.Dialog
    modality: Qt.ApplicationModal


    component CustomLabel : Label{
        property int margin: 5
        Layout.margins: margin
        Layout.maximumWidth: root.width - margin * 2
        wrapMode: Text.Wrap
        textFormat: Text.PlainText
    }

    ScrollView{
        anchors.fill: parent
        ColumnLayout{
            id: mainColumn
            spacing:10
            anchors.fill: parent
            anchors.margins: 5
            CustomLabel{
                text: "It looks like this is your first time running SainoHelicopter."
            }
            CustomLabel{
                text: "You can use the selector on the right-hand side by dragging and dropping or using the up and down keys."
            }
            CustomLabel{
                text: "You can open the control panel window by pressing the Space key."
            }
            CustomLabel{
                text: "You can switch between Wireframe view and Solid view of the 3D model by pressing the Tab key."
            }


            Button{
                text:"OK!"
                onClicked: {
                    root.close();
                }
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
