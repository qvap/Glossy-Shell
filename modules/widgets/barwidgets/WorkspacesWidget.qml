import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.components
import qs.config

Item {
    id: root
    Layout.fillHeight: true
    readonly property int padding: 15
    width: row.width + padding * 2

    RowLayout {
        id: row
        anchors {
            centerIn: parent
        }
        spacing: 20

        Repeater {
            id: repeater

            Layout.alignment: Qt.AlignVCenter

            model: Config.workspace.workspace.count

            delegate: StyledPanelRectangle {
                required property int index
                width: 20
                height: 20
            }
        }
    }
}