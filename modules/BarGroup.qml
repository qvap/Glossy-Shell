import qs.config
import qs.components
import QtQuick
import QtQuick.Layouts

/* overshot for that type of container but ok */

Item {
    id: root
    property bool vertical: false
    property real padding: 5
    implicitWidth: vertical ? Config.style.barstyle.bar_chunkiness : (gridLayout.implicitWidth + padding * 2)
    implicitHeight: vertical ? (gridLayout.implicitHeight + padding * 2) : Config.style.barstyle.bar_chunkiness - padding * 2
    default property alias items: gridLayout.data

    StyledRectangle {
        id: background
        radius: Config.style.rounding.small * 0.8
        anchors {
            fill: parent
            margins: Config.style.barstyle.bar_group_margin
        }
    }

    GridLayout {
        id: gridLayout
        columns: root.vertical ? 1 : -1
        anchors {
            centerIn: parent
        }
        columnSpacing: 4
        rowSpacing: 12
    }
}
