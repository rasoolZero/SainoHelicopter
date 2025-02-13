import QtQuick
import QtQuick3D

Model {

    property real r:0
    property color copterColor : "#EFEFEFFF"

    position: Qt.vector3d(0, 0, 0)
    source: "qrc:/mesh/APACHE_1.mesh"
    scale:Qt.vector3d(0.45,0.45,0.45)
    eulerRotation: Qt.vector3d(0,r,0)
    castsShadows: true
    receivesShadows: true
    materials: [ DefaultMaterial {
            diffuseColor: copterColor
        }
    ]
    SequentialAnimation on r {
        loops: Animation.Infinite
        NumberAnimation {
            duration: 20000
            to: 360
            from: 0
            easing.type:Easing.Linear
        }
    }
}
