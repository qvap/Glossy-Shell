import QtQuick
import QtQml
import QtQuick.Shapes
import Quickshell.Widgets
import qs.config

/* more cooler aero thingy */

Item {
    id: root

    property color mainColor: Colors.primary
    property alias radius: baseRect.radius

    LighterDropShadow {
        base: baseRect
    }
    Rectangle {
        id: baseRect
        anchors.fill: parent
        color: "black"

        radius: Config.style.rounding.normal
        gradient: LinearGradient {
            GradientStop {
                position: 0.0
                color: Qt.lighter(root.mainColor, Config.style.colorFactors.lightGradientTop)
            }
            GradientStop {
                position: 0.8
                color: Qt.darker(root.mainColor, Config.style.colorFactors.darkGradientBottom)
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
                id: glowShape
                anchors.fill: parent
                ShapePath {
                    id: shape
                    strokeWidth: 0
                    fillGradient: RadialGradient {
                        id: gradient
                        centerX: glowShape.width / 2
                        centerY: glowShape.height
                        centerRadius: glowShape.height * 0.8
                        focalX: glowShape.width / 2 //centerX
                        focalY: glowShape.height //centerY
                        GradientStop {
                            position: 0.2
                            color: Qt.lighter(root.mainColor, Config.style.colorFactors.glowLight)
                        }
                        GradientStop {
                            position: 1.0
                            color: "transparent"
                        }
                    }

                    PathMove {
                        x: 0
                        y: 0
                    }
                    PathLine {
                        relativeX: glowShape.width
                        relativeY: 0
                    }
                    PathLine {
                        relativeX: 0
                        relativeY: glowShape.height
                    }
                    PathLine {
                        relativeX: -glowShape.width
                        relativeY: 0
                    }
                    PathLine {
                        relativeX: 0
                        relativeY: -glowShape.height
                    }
                }

                transform: Scale {
                    origin.x: glowShape.width / 2
                    origin.y: glowShape.height / 2
                    xScale: Math.max(1.0, glowShape.width / Config.style.gradients.panel_glow_width)
                    yScale: 1.0
                }
            }
        }
        Rectangle { // So much rectangles 😫
            id: borderRect
            anchors.fill: parent
            color: "transparent"
            border.color: Qt.darker(root.mainColor, Config.style.colorFactors.borderDark)
            radius: baseRect.radius
            border.width: 2
            border.pixelAligned: true
        }
    }
}
