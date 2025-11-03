import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.services
import qs.components

/* the only thing thats cool in this shell */

HoverableBarWidget {
    id: root
    property bool showDate: Config.style.barstyle.show_date_in_clock_widget

    StyledText {
        wrapping: false
        font.bold: true
        color: "white"
        text: DateTime.time
    }

    StyledText {
        wrapping: false
        font.bold: true
        color: "white"
        text: "  ✧  "
        opacity: root.hovered ? 1 : 0
        Layout.preferredWidth: root.hovered ? implicitWidth : 0
    }

    StyledText {
        wrapping: false
        font.bold: true
        color: "white"
        text: DateTime.shortDate
        opacity: root.hovered ? 1 : 0
        Layout.preferredWidth: root.hovered ? implicitWidth : 0
    }
}
