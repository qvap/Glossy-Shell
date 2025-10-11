import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.components
import qs.modules
import qs.modules.widgets
import qs.config

Item {
    anchors {
        fill: parent
    }

    // Background
    StyledRectangle {
        id: barBackground
        anchors.fill: parent
        radius: Config.style.floating_bar ? Config.style.rounding : 0
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
        spacing: 5
        layoutDirection: Qt.RightToLeft

        BarGroup {
            id: rightWidgetsGroup
            Layout.alignment: Qt.AlignVCenter

            ClockWidget {
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }
}
