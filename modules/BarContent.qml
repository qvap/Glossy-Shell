import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.components
import qs.modules
import qs.modules.widgets.barwidgets
import qs.config

/* ofc I have no important things to do than leaving this comments */

Item {
    anchors {
        fill: parent
    }

    // Background
    StyledRectangle {
        id: barBackground
        anchors.fill: parent
        radius: Config.style.barstyle.floating_bar ? Config.style.rounding.small : 0
    }

    RowLayout {
        id: leftSection
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: middleSection.left
        }
        spacing: 10

        WorkspacesWidget {
            Layout.alignment: Qt.AlignVCenter
        }
    }

    RowLayout {
        id: middleSection
        anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 4
    }

    RowLayout {
        id: rightSection
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: undefined
            right: parent.right
            rightMargin: 1
        }
        spacing: -7
        layoutDirection: Qt.RightToLeft

        BarGroup {
            id: clockGroup
            Layout.alignment: Qt.AlignVCenter

            ClockWidget {
                Layout.alignment: Qt.AlignVCenter
            }
        }

        BarGroup {
            id: layoutGroup
            Layout.alignment: Qt.AlignVCenter

            KbLayoutWidget {
                Layout.alignment: Qt.AlignVCenter
            }
        }

        BarGroup {
            id: batteryGroup
            Layout.alignment: Qt.AlignVCenter

            BatteryWidget {
                Layout.alignment: Qt.AlignVCenter
            }
        }

        BarGroup {
            id: volumeGroup
            Layout.alignment: Qt.AlignVCenter

            VolumeWidget {
                Layout.alignment: Qt.AlignVCenter
            }
        }

        BarGroup {
            id: trayGroup
            Layout.alignment: Qt.AlignVCenter

            TrayWidget {
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }
}
