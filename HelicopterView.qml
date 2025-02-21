import QtQuick
import QtQuick3D
import QtQuick3D.Helpers


View3D {
    id : view
    property alias copterColor : copter.copterColor

    // renderFormat: ShaderEffectSource.RGBA16F
    environment: SceneEnvironment {
        id: env
        backgroundMode: SceneEnvironment.Transparent
        antialiasingMode: SceneEnvironment.MSAA
        antialiasingQuality: SceneEnvironment.High
    }
    camera: mainCamera
    Node{
        id: originNode
        OrthographicCamera {
            id: mainCamera
            position: Qt.vector3d(0, 0,1000)
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

    onWidthChanged: adjustCamera()
    onHeightChanged: adjustCamera()
    Component.onCompleted: adjustCamera()

    function adjustCamera() {

        var bounds = copter.bounds;
        var minPoint = bounds.minimum;
        var maxPoint = bounds.maximum;

        let padding = 1.05

        var modelWidth = (maxPoint.x - minPoint.x) * padding;
        var modelHeight = (maxPoint.y - minPoint.y) * padding;
        var modelDepth = (maxPoint.z - minPoint.z) * padding;


        // Determine the maximum model dimension
        var maxModelWidth = Math.max(modelWidth, modelDepth);

        var heightScale = view.height / modelHeight;
        var widthScale = view.width / maxModelWidth;

        // Compute scale factor based on the View3D size
        var scaleFactor = Math.min(heightScale, widthScale);

        // Apply uniform scaling to keep proportions
        copter.scaleFactor = scaleFactor

        // console.log("\nbounds : ", bounds
        //             ,"\nmodelWidth : ",modelWidth
        //             ,"\nmodelHeight : ",modelHeight
        //             ,"\nmodelDepth : ",modelDepth
        //             ,"\nview.width : ",view.width
        //             ,"\nview.height : ",view.height
        //             ,"\nfactor : ",scaleFactor
        //             ,"\n");
    }
}
