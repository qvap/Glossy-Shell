pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.components
import qs.config
import qs.services
import qs
import "../../scripts/fuzzysearch.js" as Fuzzy

StyledListView {
    id: root

    required property string searchText
    required property real maskLength

    readonly property int itemHeight: 56

    spacing: Config.style.spacing.standart
    clip: true
    orientation: ListView.Vertical
    verticalLayoutDirection: ListView.BottomToTop

    highlightFollowsCurrentItem: true
    highlightMoveDuration: Config.animation.duration.small
    highlightMoveVelocity: -1 // use duration instead
    preferredHighlightBegin: 0
    preferredHighlightEnd: height * (1 - maskLength)
    highlightRangeMode: ListView.ApplyRange

    readonly property var filteredApps: {
        const filtered = DesktopEntries.applications.values.filter(app => Fuzzy.fuzzy_search(app.name, searchText));
        return filtered.sort((a, b) => a.name.localeCompare(b.name));
    }

    model: ScriptModel {
        values: root.filteredApps
        onValuesChanged: root.currentIndex = 0
    }

    delegate: AppItem {
        implicitHeight: root.itemHeight
        onItemClicked: itemIndex => {
            root.highlightFollowsCurrentItem = false;
            root.highlightRangeMode = ListView.NoHighlightRange;
            root.currentIndex = itemIndex;
            Qt.callLater(() => {
                root.highlightFollowsCurrentItem = true;
                root.highlightRangeMode = ListView.ApplyRange;
            });
        }
    }

    footer: Item {
        width: root.width
        height: root.itemHeight - root.spacing
    }

    component SinglePropertyTransition: Transition {
        required property string animatedProperty

        BaseAnimation {
            property: animatedProperty
            easing.type: Easing.OutCubic
            duration: Config.animation.duration.normal
        }
    }

    component MultiPropertyTransition: Transition {
        required property string animatedProperties
        property real targetValue

        BaseAnimation {
            properties: animatedProperties
            to: targetValue
            easing.type: Easing.OutCubic
            duration: Config.animation.duration.normal
        }
    }

    displaced: SinglePropertyTransition {
        animatedProperty: "y"
    }
    addDisplaced: SinglePropertyTransition {
        animatedProperty: "y"
    }
    remove: MultiPropertyTransition {
        animatedProperties: "opacity,scale"
        targetValue: 0
    }
    add: MultiPropertyTransition {
        animatedProperties: "opacity,scale"
        targetValue: 1
    }

    function execute() {
        currentItem?.execute();
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
            GradientStop {
                position: 0.0
                color: Qt.rgba(0, 0, 0, 0)
            }
            GradientStop {
                position: root.maskLength
                color: Qt.rgba(0, 0, 0, 1)
            }
        }
    }
}
