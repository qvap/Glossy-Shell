import QtQuick
import QtQuick.Controls
import qs.config

TextField {
    id: root

    color: "#000000"
    placeholderTextColor: "#222222"

    background: Rectangle {
        color: "#222222"
        radius: Config.style.rounding
        border.width: 0
    }
    
}