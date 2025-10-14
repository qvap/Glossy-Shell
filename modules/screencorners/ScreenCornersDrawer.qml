import QtQuick
import QtQuick.Effects
import Quickshell
import qs.config

Item {
    id: root

    anchors.fill: parent
    Rectangle {
        anchors.fill: parent
        color: "black"

        layer.enabled : true
        layer.effect: MultiEffect {
            maskSource: mask
            maskEnabled: true
            maskInverted: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
        }

    Item {
        id: mask
        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
            id: maskInner

            anchors.fill: parent
            radius: Config.style.rounding.screen_rounding
            }
        }
    }
}