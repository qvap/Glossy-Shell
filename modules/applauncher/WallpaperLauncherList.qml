pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.components
import qs.config
import qs.services

StyledListView {
    id: root

    required property string searchText
    required property real maskLength
    readonly property int itemWidth: 100

    spacing: itemWidth

    clip: true

    orientation: ListView.Horizontal

    highlightFollowsCurrentItem: true
    highlightMoveDuration: Config.animation.duration.small
    highlightMoveVelocity: -1
    preferredHighlightBegin: width / 2 - itemWidth / 2
    preferredHighlightEnd: width / 2 + itemWidth / 2
    highlightRangeMode: ListView.StrictlyEnforceRange

    model: ScriptModel {
        values: Wallpapers.filterWallpapers(searchText)
        onValuesChanged: root.currentIndex = 0
    }

    delegate: WallpaperItem {
        currentIndex: root.currentIndex
        itemWidth: root.itemWidth
        onItemClicked: itemIndex => {
            root.currentIndex = itemIndex;
        }
    }

    function execute() {
        if (root.currentItem) {
            currentItem.setWallpaper();
        }
    }

    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: maskRect
    }

    Rectangle {
        id: maskRect

        layer.enabled: true
        visible: false

        anchors {
            fill: parent
        }
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop {
                position: 0.0
                color: Qt.rgba(0, 0, 0, 0)
            }
            GradientStop {
                position: root.maskLength
                color: Qt.rgba(0, 0, 0, 1)
            }
            GradientStop {
                position: 1.0 - root.maskLength
                color: Qt.rgba(0, 0, 0, 1)
            }
            GradientStop {
                position: 1.0
                color: Qt.rgba(0, 0, 0, 0)
            }
        }
    }
}
