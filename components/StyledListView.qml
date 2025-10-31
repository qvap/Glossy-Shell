import QtQuick
import Quickshell
import qs.components

/* can I get one uuhhhhh uuuuuuuuuuhhhhhhhhhhhhhhh uhhhhhhhhhhhhhhhhhhhhhhh uuhh uh uhhhhhhhhhhhh */

ListView {
    id: root

    maximumFlickVelocity: 3000

    rebound: Transition {
        BaseAnimation {
            properties: "x,y"
            easing.type: Easing.OutQuad
        }
    }
}
