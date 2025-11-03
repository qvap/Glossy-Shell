import QtQuick
import QtQuick.Layouts
import qs.config

Item {
    id: root

    default property alias contentItems: rowLayout.data
    property alias spacing: rowLayout.spacing

    implicitWidth: rowLayout.implicitWidth + padding * 2
    implicitHeight: Config.style.barstyle.bar_chunkiness - padding * 2

    property int padding: 10
    property bool hovered: false
    property int hoverTimeout: 1000

    Timer {
        id: hoverTimer
        interval: root.hoverTimeout
        onTriggered: root.hovered = false
    }

    MouseArea {
        anchors {
            fill: parent
        }
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: hoverTimer.restart()
    }

    function restartTimer() {
        hoverTimer.restart()
    }

    function expand() {
        root.hovered = true;
        restartTimer()
    }

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 0
        clip: true
    }
}
