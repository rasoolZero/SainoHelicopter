import QtQuick
import QtQuick.Layouts

Item {

    property alias barCount: repeater.model
    property color color: "white"
    property int spacing: layout.spacing
    property bool running: true
    property real minimumBarWidth:0
    onWidthChanged: updateMinimumWidth()
    function updateMinimumWidth(){
        let minimumSoFar = Number.POSITIVE_INFINITY;
        for(var i = 0 ; i < repeater.count ; i++){
            let w = repeater.itemAt(i).width;
            if(w < minimumSoFar)
                minimumSoFar = w;
        }
        minimumBarWidth = minimumSoFar;
    }

    id: root
    onRunningChanged: {
        if (barCount !== repeater.count || timer._barIndex <= barCount - 1) {
            return;
        }

        for (var barIndex = 0; barIndex < barCount; barIndex++) {
            if (running) {
                if (repeater.itemAt(barIndex)) {
                    repeater.itemAt(barIndex).playAnimation();
                }
            }
            else {
                if (repeater.itemAt(barIndex)) {
                    repeater.itemAt(barIndex).pauseAnimation();
                }
            }
        }
    }

    RowLayout{
        id: layout
        uniformCellSizes: true
        anchors.fill: root
        Repeater {
            id: repeater
            model: 5
            delegate: Component{ Rectangle {
                Layout.minimumHeight: layout.height/2
                Layout.maximumHeight: layout.height/2
                Layout.fillWidth: true
                transform: Scale {
                    id: rectScale
                    origin {
                        x: width / 2
                        y: height / 2
                    }
                }
                transformOrigin: Item.Center
                color: root.color
                onWidthChanged: {
                    if(width < root.minimumBarWidth)
                        root.minimumBarWidth = width;
                }

                SequentialAnimation {
                    id: anim
                    loops: Animation.Infinite

                    NumberAnimation { target: rectScale; property: "yScale"; from: 1; to: 1.5; duration: 300 }
                    NumberAnimation { target: rectScale; property: "yScale"; from: 1.5; to: 1; duration: 300 }
                    PauseAnimation { duration: root.barCount * 150 }
                }

                function playAnimation() {
                    if (anim.running === false) {
                        anim.running = true;
                    }

                    if (anim.paused) {
                        anim.paused = false;
                    }
                }

                function pauseAnimation() {
                    if (anim.running) {
                        anim.paused = true;
                    }
                }
            }}
        }
    }

    Timer {
        // ----- Private Properties ----- //
        property int _barIndex: 0

        id: timer
        interval: 80
        repeat: true
        onTriggered: {
            if (_barIndex === root.barCount) {
                stop();
            }
            else {
                repeater.itemAt(_barIndex).playAnimation();
                if (root.running === false) {
                    repeater.itemAt(_barIndex).pauseAnimation();
                }

                _barIndex++;
            }
        }
        Component.onCompleted: start()
    }
}
