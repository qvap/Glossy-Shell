import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.components
import qs.config

Item {
    id: root
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)

    StyledText {
        text: `Workspace ${monitor?.activeWorkspace?.id ?? 1}`
        font {
            pixelSize: Config.style.fonts.veryLargeSize
        }
        color: Qt.lighter(Colors.primary, 1.8)
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: Config.style.spacing.standart
        }
    }
}
