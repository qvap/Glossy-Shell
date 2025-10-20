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
    property alias radius: base.radius

    /*LighterDropShadow {
        base: base
    }*/
    Rectangle { // some dropoff 'cause the text is unreadable
        anchors {
            fill: parent
        }
        color: "#00364f"
        radius: Config.style.rounding.rounding
        opacity: 0
    }

    Rectangle {
        id: base
        anchors {
            fill: parent
        }
        radius: Config.style.rounding.rounding
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(1, 1, 1, 0.8) }
            GradientStop { position: 1.0; color: Qt.rgba(0.8, 0.9, 1, 0.4) }
        }
        opacity: 0.9
        border {
            color: Qt.rgba(1, 1, 1, 1)
            width: 1
        }
    }
}