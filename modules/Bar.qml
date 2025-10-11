import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.components
import qs.components.containers
import qs.config
import qs.modules

Variants {
    model: Quickshell.screens
    ContainerWindow {
        name: "bar"
        required property ShellScreen modelData

        anchors {
            left: true
            bottom: true
            right: true
        }

        /* it has 8 because we need to compensate
        big container window for shadow */
        exclusiveZone: Config.style.bar_chunkiness - 8

        implicitHeight: Config.style.bar_chunkiness

        BarContent {
            anchors {
                topMargin: Config.style.floating_bar ? 5: 0
                leftMargin: Config.style.floating_bar ? 5: 0
                rightMargin: Config.style.floating_bar ? 5: 0
                bottomMargin: Config.style.floating_bar ? 5: 0
            }
        }
    }
}
