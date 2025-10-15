import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell.Widgets
import qs.config

/* more cooler aero thingy */

Item {
    id: root
    property alias radius: baseRect.radius

    LighterDropShadow {
        base: baseRect
    }
    Rectangle {
        id: baseRect
        anchors.fill: parent
        color: "black"

        radius: Config.style.rounding.rounding
        gradient: LinearGradient {
            GradientStop {
                position: 0.0
                color: "#b2c5ff"
            }
            GradientStop {
                position: 0.8
                color: "#182e60"
            }
        }
        antialiasing: true

        /*docs say this is the most cost-perfomance widget but
            I dont fucking know how to do it the other way*/

        ClippingRectangle {
            id: gradientClip
            anchors {
                fill: parent
                margins: 1 // avoid clipped area exceeding through borders
            }
            radius: baseRect.radius
            color: "transparent"
            Shape {
                ShapePath {
                    id: shape
                    strokeWidth: 0
                    fillGradient: RadialGradient {
                        id: gradient
                        centerX: shape.startX + root.width / 2
                        centerY: root.height
                        centerRadius: root.height * 0.8
                        focalX: centerX
                        focalY: centerY
                        GradientStop {
                            position: 0.2
                            color: Qt.rgba(0, 183, 255, 1)
                        }
                        GradientStop {
                            position: 1.0
                            color: "transparent"
                        }
                    }

                    PathRectangle {
                        width: root.width
                        height: root.height
                    }
                }

                transform: Scale {
                    origin.x: root.width / 2
                    origin.y: root.height / 2
                    xScale: root.width / Config.style.gradients.panel_glow_width
                    yScale: 1.0
                }
            }
        }
        Rectangle { // So much rectangles 😫
            id: borderRect
            anchors.fill: parent
            color: "transparent"
            border.color: "#1d3d88"
            radius: baseRect.radius
            border.width: 2
            border.pixelAligned: true
        }
    }
}
