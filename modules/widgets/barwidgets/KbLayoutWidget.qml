import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.services
import qs.components

Item {
    id: root
    property int padding: 10
    property bool showDate: Config.style.barstyle.show_date_in_clock_widget
    implicitWidth: rowLayout.implicitWidth + padding * 2
    implicitHeight: Config.style.barstyle.bar_chunkiness - padding * 2

    property bool hovered: false

    Timer {
        id: hoverTimer
        onTriggered: {
            root.hovered = false;
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: {
            if (hoverTimer.running) {
                hoverTimer.stop();
            }
            hoverTimer.start();
        }
    }
    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 0

        clip: true

        StyledText {
            wrapping: false
            font.bold: true
            color: "white"
            text: HyprlandXkb.currentLayoutCode.toUpperCase()
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
            id: kbcode
            wrapping: false
            font.bold: true
            color: "white"
            text: HyprlandXkb.currentLayoutName
            opacity: root.hovered ? 1 : 0
            Layout.preferredWidth: root.hovered ? implicitWidth : 0

            onTextChanged: {
                anim.start();
            }
        }

        SequentialAnimation {
            id: anim

            BaseAnimation {
                target: kbcode
                property: "opacity"
                from: 0
                to: 1
            }
        }
    }
}
