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

    background: Rectangle {
        color: "transparent"
    }
}