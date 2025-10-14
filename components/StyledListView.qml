import QtQuick
import qs.components

/* can I get one uuhhhhh uuuuuuuuuuhhhhhhhhhhhhhhh uhhhhhhhhhhhhhhhhhhhhhhh uuhh uh uhhhhhhhhhhhh */

ListView {
    id: root

    maximumFlickVelocity: 3000

    rebound: Transition {
        BaseAnimation {
            properties: "x,y"
        }
    }

    add: Transition {
        BaseAnimation {
            properties: "opacity,scale"
            from: 0; to: 1
        }
    }
}