import QtQuick
import QtQuick3D
Node{
    id: root
    property real scaleFactor: 1
    onScaleFactorChanged: {
        let height = (bounds.maximum.y - bounds.minimum.y) * scaleFactor;
        let yTransform = height * 4 / 5; // Center the model correctly
        position = Qt.vector3d(0, -yTransform, 0);
    }
    position: Qt.vector3d(0, 0, 0)
    scale:Qt.vector3d(scaleFactor,scaleFactor,scaleFactor)
    property real r:0
    property color copterColor : "#EFEFEFFF"
    property alias bounds : model.bounds
    Model {
        id: model
        source: "qrc:/mesh/APACHE_1.mesh"
        eulerRotation: Qt.vector3d(0,r,0)
        castsShadows: true
        receivesShadows: true
        materials: [ DefaultMaterial {
                diffuseColor: root.copterColor
            }
        ]
    }
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
