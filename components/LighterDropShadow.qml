import QtQuick
import QtQuick.Effects

/* cost-efficient shadow for rectangles */

RectangularShadow {

    required property Rectangle base

    anchors {
        fill: base
    }
    radius: base.radius
    offset.y: 5
    blur: 10
    opacity: 0.3
}