import QtQuick
import qs.components

ListView {
    id: root

    maximumFlickVelocity: 3000

    rebound: Transition {
        BaseAnimation {
            properties: "x,y"
        }
    }
}