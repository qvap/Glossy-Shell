import qs.config
import qs.components
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    property bool vertical: false
    property real padding: 5
    implicitWidth: vertical ? Config.style.bar_chunkiness : (gridLayout.implicitWidth + padding * 2)
    /* another cursed property (wont rework cause it works anyway and I dont care) */
    implicitHeight: vertical ? (gridLayout.implicitHeight + padding * 2) : Config.style.bar_chunkiness - padding * 2.5 // this coefficient sucks
    default property alias items: gridLayout.data

    StyledRectangle {
        id: background
        anchors {
            fill: parent
            margins: Config.style.bar_group_margin
            //topMargin: root.vertical ? 0 : Config.style.bar_group_margin
            //bottomMargin: root.vertical ? 0 : Config.style.bar_group_margin
            //leftMargin: root.vertical ? Config.style.bar_group_margin : 0
            //rightMargin: root.vertical ? Config.style.bar_group_margin : 0
        }
    }

    GridLayout {
        id: gridLayout
        columns: root.vertical ? 1 : -1
        anchors {
            centerIn: parent
            //verticalCenter: root.vertical ? undefined : parent.verticalCenter
            //horizontalCenter: root.vertical ? parent.horizontalCenter : undefined
            //left: root.vertical ? undefined : parent.left
            //right: root.vertical ? undefined : parent.right
            //top: root.vertical ? parent.top : undefined
            //bottom: root.vertical ? parent.bottom : undefined
            //margins: root.padding
        }
        columnSpacing: 4
        rowSpacing: 12
    }
}
