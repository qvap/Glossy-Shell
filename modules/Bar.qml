import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.components
import qs.components.containers
import qs.config
import qs.modules

/* you should delete your computer now */

Item {
    anchors {
        left: parent?.left
        bottom: parent?.bottom
        right: parent?.right
    }

    implicitHeight: Config.style.barstyle.bar_chunkiness

    BarContent {
        anchors {
            topMargin: Config.style.barstyle.floating_bar ? 5: 0
            leftMargin: Config.style.barstyle.floating_bar ? 5: 0
            rightMargin: Config.style.barstyle.floating_bar ? 5: 0
            bottomMargin: Config.style.barstyle.floating_bar ? 5: 0
        }
    }
}