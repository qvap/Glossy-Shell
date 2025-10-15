pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.components

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

    displaced: Transition {
        BaseAnimation { property: "y"; easing.type: Easing.OutCubic; duration: 400 }
    }

    addDisplaced: Transition {
        BaseAnimation { property: "y"; easing.type: Easing.OutCubic; duration: 400 }
    }
    
    remove: Transition {
        BaseAnimation { properties: "opacity,scale"; to: 0; easing.type: Easing.OutCubic; duration: 400 }
    }

    add: Transition {
        BaseAnimation { properties: "opacity,scale"; to: 1; easing.type: Easing.OutCubic; duration: 400 }
    }

    model: ScriptModel {
        id: model

        values: getSearchApps(searchText)
        onValuesChanged: root.currentIndex = 0
    }
    
    delegate: AppItem {}

    function getSearchApps(searchText) : list<var> {
        return DesktopEntries.applications.values.filter(a => a.name.toLowerCase().includes(searchText.toLowerCase()))
    }
}