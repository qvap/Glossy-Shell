import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.services
import qs.components

Item {
    id: root
    property int padding: 10
    property bool showDate: Config.style.show_date_in_clock_widget
    implicitWidth: rowLayout.implicitWidth + padding * 2
    implicitHeight: Config.style.bar_chunkiness - padding * 2

    property bool hovered: false

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: root.hovered = false
    }

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 0

        StyledText {
            font.bold: true
            color: "white"
            text: DateTime.shortDate
            opacity: hovered ? 1 : 0
            Layout.preferredWidth: hovered ? implicitWidth : 0
        }

        StyledText {
            font.bold: true
            Layout.topMargin: 1
            color: "white"
            text: "  ✧  "
            opacity: hovered ? 1 : 0
            Layout.preferredWidth: hovered ? implicitWidth : 0
        }
    
        StyledText {
            font.bold: true
            color: "white"
            text: DateTime.time
        }
    }
}