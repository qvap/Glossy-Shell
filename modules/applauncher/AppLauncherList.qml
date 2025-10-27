pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.components
import qs.config
import "../../scripts/fuzzysearch.js" as Fuzzy

StyledListView {
    id: root

    required property string searchText

    spacing: 12

    clip: true

    orientation: Qt.Vertical

    verticalLayoutDirection: ListView.BottomToTop

    highlightFollowsCurrentItem: false
    preferredHighlightBegin: 0
    preferredHighlightEnd: height
    highlightRangeMode: ListView.ApplyRange
    highlight: StyledRectangle {
        opacity: 0.6

        y: root.currentItem?.y ?? 0
        implicitWidth: root.width
        implicitHeight: root.currentItem?.implicitHeight ?? 0
    }

    displaced: Transition {
        BaseAnimation { property: "y"; easing.type: Easing.OutCubic; duration: Config.animation.duration.normal }
    }

    addDisplaced: Transition {
        BaseAnimation { property: "y"; easing.type: Easing.OutCubic; duration: Config.animation.duration.normal }
    }
    
    remove: Transition {
        BaseAnimation { properties: "opacity,scale"; to: 0; easing.type: Easing.OutCubic; duration: Config.animation.duration.normal }
    }

    add: Transition {
        BaseAnimation { properties: "opacity,scale"; to: 1; easing.type: Easing.OutCubic; duration: Config.animation.duration.normal }
    }

    model: ScriptModel {
        values: getSearchApps(searchText)
        onValuesChanged: root.currentIndex = 0
    }
    
    delegate: AppItem { onItemClicked: (itemIndex) => { root.currentIndex = itemIndex } }

    function getSearchApps(searchText) : list<var> {
        return (DesktopEntries.applications.values.filter(a => Fuzzy.fuzzy_search(a.name, searchText))).sort((a, b) => a.name.localeCompare(b.name))
    }

    function execute() {
        if (root.currentItem) {
            currentItem.execute()
        }
    }
}