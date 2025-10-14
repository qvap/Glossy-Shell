import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.components

/* aero thingy */

Item {
    id: root

    property alias color: base.color

    LighterDropShadow {
        base: base
    }

    Rectangle {
        id: base
        anchors {
            fill: parent
        }
        radius: Config.style.rounding.rounding
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(255, 255, 255, 0.8) }
            GradientStop { position: 1.0; color: Qt.rgba(255, 255, 255, 0.2) }
        }
        opacity: 0.8
        border {
            color: Qt.rgba(255, 255, 255, 1)
            width: 2
        }
    }
}