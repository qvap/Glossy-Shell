import QtQuick
import QtQuick.Controls
import qs.config

/* 21 */

TextField {
    id: root

    color: "#ffffff"
    placeholderTextColor: "#d6d6d6"

    font {
        family: Config.style.fonts.sans
        pixelSize: Config.style.fonts.largeSize
    }

    placeholderText: "Search..."

    topPadding: 0
    bottomPadding: 1 // why this stupid field is not centered
    leftPadding: 0
    rightPadding: 0

    background: Rectangle {
        color: "transparent"
    }
}
