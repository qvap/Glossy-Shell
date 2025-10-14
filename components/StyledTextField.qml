import QtQuick
import QtQuick.Controls
import qs.config

/* 21 */

TextField {
    id: root

    color: "#ffffff"
    placeholderTextColor: "#bfbfbf"

    font {
        family: Config.style.fonts.sans
        pixelSize: 16
    }

    placeholderText: "Search..."

    background: Rectangle {
        color: "transparent"
    }
}