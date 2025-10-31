import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import qs.config

MouseArea {
    id: root

    required property SystemTrayItem modelData

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    implicitWidth: Config.style.fonts.veryLargeSize
    implicitHeight: Config.style.fonts.veryLargeSize

    onClicked: event => {
        if (event.button === Qt.LeftButton) {
            modelData.activate();
        } else {
            modelData.secondaryActivate();
        }
    }

    IconImage {
        id: icon
        anchors {
            fill: parent
        }
        source: root.modelData.icon
    }
}
