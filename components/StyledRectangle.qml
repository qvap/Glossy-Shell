import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell.Widgets
import qs.config

Rectangle {
    id: root
    color: "black"
    radius: Config.style.rounding
    gradient: LinearGradient {
        GradientStop { position: 0.0; color: "#b2c5ff"}
        GradientStop { position: 0.8; color: "#182e60"}
    }
    antialiasing: true

    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled:true
        shadowColor: "#000000"
    }

    /*docs say this is the most cost-perfomance widget but
    I dont fucking know how to do it the other way*/

    ClippingRectangle {
        anchors.fill: parent
        anchors.bottomMargin: parent.border.width
        radius: root.radius
        color: "transparent"
        Shape {
            id: shape
            anchors.fill: parent

            transform: Scale {
                origin.x: root.width / 2
                origin.y: root.height / 2
                xScale: root.width / Config.style.panel_glow_width
                yScale: 1.0
            }
            ShapePath {
                strokeWidth: 0
                fillGradient: RadialGradient {
                    id: gradient
                    centerX: root.x + root.width / 2
                    centerY: root.y + root.height
                    centerRadius: root.height * 0.8
                    focalX: centerX; focalY: centerY
                    GradientStop { position: 0.2; color: Qt.rgba(0, 183, 255, 1)}
                    GradientStop { position: 1.0; color: "transparent" }
                }

                PathRectangle {
                    width: parent.width
                    height: parent.height
                }
            }
        }
    }
    Rectangle { // So much rectangles 😫
        id: borderRect
        anchors.fill: parent
        color: "transparent"
        border.color: "#182e60"
        radius: root.radius
        border.width: 2
        border.pixelAligned: true
    }
    
}