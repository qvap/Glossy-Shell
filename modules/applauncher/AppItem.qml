import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.components
import qs

/* no courage because I can't design aero */

Item {
    id: root

    required property DesktopEntry modelData
    required property int index
    property int blurEffect: 0

    implicitHeight: 46
    implicitWidth: parent ? parent.width : 200

    signal itemClicked(int itemIndex)

    StyledPanelRectangle {
        id: background
        anchors {
            fill: parent
        }
    }

    MouseArea {
        anchors {
            fill: parent
        }
        onClicked: {
            root.itemClicked(index)
        }
        onDoubleClicked: {
            root.execute()
            Global.launcherOpen = false
        }
    }

    RowLayout {
        id: rowLayout

        anchors {
            left: background.left
            top: background.top
            bottom: background.bottom
            leftMargin: 15
        }

        spacing: 15

        IconImage {
            source: Quickshell.iconPath(modelData.icon, "image-missing")
            implicitSize: 28
        }

        StyledText {
            text: modelData.name
            font.pixelSize: 18
            color: "white"
        }

        /*Loader {
            active: modelData.comment !== ""

            sourceComponent: StyledText {
                width: 370
                text: modelData.comment
                font.pixelSize: 12
                color: "#bbbbbb"
            }
        }*/
    }

    function execute() {
        modelData.execute()
    }
}