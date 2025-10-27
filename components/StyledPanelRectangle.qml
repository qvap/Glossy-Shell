import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.components

/* aero thingy */

Item {
    id: root

    property color mainColor: Colors.primary
    property alias radius: base.radius

    /*LighterDropShadow {
        base: base
    }*/
    Rectangle { // some dropoff 'cause the text is unreadable
        anchors {
            fill: parent
        }
        color: Qt.darker(root.mainColor, 3.0)
        radius: Config.style.rounding.normal
        opacity: 0.6
    }

    Rectangle {
        id: base
        anchors {
            fill: parent
        }
        radius: Config.style.rounding.normal
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.hsla(root.mainColor.hslHue, root.mainColor.hslSaturation, 0.95, 1.0) }
            GradientStop { position: 1.0; color: Qt.hsla(root.mainColor.hslHue, root.mainColor.hslSaturation, 0.95, 0.4) }
        }
        opacity: 0.9
        border {
            color: Qt.lighter(root.mainColor, 2.0)
            width: 1
        }
    }
}
