pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.config

Item {
    id: root
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)

    implicitWidth: workspaceRow.implicitWidth
    implicitHeight: workspaceRow.implicitHeight

    RowLayout {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 8

        Repeater {
            model: Config.workspace.workspace.count

            Rectangle {
                id: bubble
                required property int index
                readonly property int workspaceId: index + 1
                readonly property bool isActive: root.monitor?.activeWorkspace?.id === workspaceId

                Layout.preferredWidth: isActive ? 12 : 8
                Layout.preferredHeight: isActive ? 12 : 8
                radius: Layout.preferredWidth / 2
                color: isActive ? Qt.lighter(Colors.primary, 1.8) : Qt.darker(Colors.primary, 1.8)

                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                Behavior on Layout.preferredWidth {
                    NumberAnimation {
                        duration: Config.animation.duration.small
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: Config.animation.curves.emphasized
                    }
                }

                Behavior on Layout.preferredHeight {
                    NumberAnimation {
                        duration: Config.animation.duration.small
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: Config.animation.curves.emphasized
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: Config.animation.duration.small
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: Config.animation.curves.standard
                    }
                }
            }
        }
    }
}
