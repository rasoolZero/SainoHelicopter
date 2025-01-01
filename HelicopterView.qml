import QtQuick
import QtQuick3D
import QtQuick3D.Helpers


View3D {
    id : view
    property alias bgColor : env.clearColor
    property alias copterColor : copter.copterColor


    // renderFormat: ShaderEffectSource.RGBA16F
    environment: SceneEnvironment {
        id: env
        clearColor: "black"
        backgroundMode: SceneEnvironment.Color
        antialiasingMode: SceneEnvironment.MSAA
        antialiasingQuality: SceneEnvironment.High
    }
    camera: mainCamera
    Node{
        id: originNode
        OrthographicCamera {
            id: mainCamera
            position: Qt.vector3d(0, 155,1000)
            clipNear: 1.0
            clipFar:1000000.0
        }
    }
    // OrbitCameraController {
    //     anchors.fill: parent
    //     origin: originNode
    //     camera: mainCamera
    // }

    DirectionalLight {
        eulerRotation.x: 0
        eulerRotation.y: 0
    }

    Helicopter {
        id: copter
    }

//     Text{
//         property vector3d rot
//         id:debugTest
//         color: "white"
//         font.pixelSize: 16
//         text : `${originNode.rotation.x},${originNode.rotation.y},${originNode.rotation.z}
// ${copter.bounds.minimum}
// ${copter.bounds.maximum}`
//     }
}
