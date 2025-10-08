import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.components
import qs.config
import qs.modules

Variants {
    model: Quickshell.screens
    PanelWindow {
        required property ShellScreen modelData

        color: "transparent"

        anchors {
            left: true
            bottom: true
            right: true
        }

        /* cursed ahh margins */

        margins {
            top: -10
        }

        implicitHeight: Config.style.bar_chunkiness + 10

        BarContent {
            anchors {
                topMargin: Config.style.floating_bar ? 10: 0
                leftMargin: Config.style.floating_bar ? 5: 0
                rightMargin: Config.style.floating_bar ? 5: 0
                bottomMargin: Config.style.floating_bar ? 5: 0
            }
        }
    }
}
