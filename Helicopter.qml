import QtQuick
import QtQuick3D
Node{
    id: root
    property real scaleFactor: 1
    property bool showWireframe : true
    onScaleFactorChanged: {
        let height = (bounds.maximum.y - bounds.minimum.y) * scaleFactor;
        let yTransform = height * 4 / 5; // Center the model correctly
        position = Qt.vector3d(0, -yTransform, 0);
    }
    position: Qt.vector3d(0, 0, 0)
    scale:Qt.vector3d(scaleFactor,scaleFactor,scaleFactor)
    property color copterColor : "#EFEFEFFF"
    property alias bounds : model.bounds
    Model {
        id: model
        source: "qrc:/mesh/APACHE_1_lower.mesh"
        castsShadows: true
        receivesShadows: true
        materials: [ DefaultMaterial {
                diffuseColor: root.copterColor
            }
        ]
        visible: root.showWireframe

        Vector3dAnimation on eulerRotation {
            loops: Animation.Infinite
            duration: 20000
            from: Qt.vector3d(0,0,0)
            to: Qt.vector3d(0,360,0)
            easing.type:Easing.Linear
        }
    }
    Model {
        source: "qrc:/mesh/ah64_APACHE_mesh.mesh"
        eulerRotation: model.eulerRotation
        castsShadows: true
        receivesShadows: true
        materials: [ DefaultMaterial {
                diffuseColor: Qt.darker(root.copterColor,1.15)
            }
        ]
        visible: !root.showWireframe
    }
}
