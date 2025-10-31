import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import qs.config
import qs.services
import qs.components

Item {
    id: root
    property int padding: 10
    implicitWidth: rowLayout.implicitWidth + padding * 2
    implicitHeight: Config.style.barstyle.bar_chunkiness - padding * 2

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: Config.style.spacing.small

        clip: true

        Repeater {
            id: items

            model: SystemTray.items

            TrayItem {}
        }
    }
}
