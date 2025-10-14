import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.services
import qs.components

/* the only thing thats cool in this shell */

Item {
    id: root
    property int padding: 10
    property bool showDate: Config.style.barstyle.show_date_in_clock_widget
    implicitWidth: rowLayout.implicitWidth + padding * 2
    implicitHeight: Config.style.barstyle.bar_chunkiness - padding * 2

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
            wrapping: false
            font.bold: true
            color: "white"
            text: DateTime.shortDate
            opacity: hovered ? 1 : 0
            Layout.preferredWidth: hovered ? implicitWidth : 0
        }

        StyledText {
            wrapping: false
            font.bold: true
            color: "white"
            text: "  ✧  "
            opacity: hovered ? 1 : 0
            Layout.preferredWidth: hovered ? implicitWidth : 0
        }
    
        StyledText {
            wrapping: false
            font.bold: true
            color: "white"
            text: DateTime.time
        }
    }
}