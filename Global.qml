pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

/* global states or smth */
// SOME ELEMENTS ARE VIBE_CODED // SUBJECT TO REVIEW

Singleton {
    id: root

    readonly property bool hasFullscreen: Hyprland.focusedWorkspace?.hasFullscreen ?? false

    onHasFullscreenChanged: {
        Global.launcherOpen = false;
        Global.barOpen = Global.hasFullscreen ? false : true;
    }

    property bool launcherOpen: false
    property bool barOpen: true

    property int _popOutSeq: 0
    property bool popOutVisible: false
    property real popOutX: 0
    property real popOutY: 0
    property string popOutTitle: ""
    property string popOutDescription: ""
    property var popOutMenu: null

    // submenu stack: each entry is { menu, x, y, parentIndex }
    property var subMenuStack: []
    property int _subMenuSeq: 0

    function openSubMenu(menuEntry, rightX, leftX, globalY, depth) {
        // close deeper levels
        let stack = subMenuStack.slice(0, depth);
        stack.push({
            menu: menuEntry,
            rightX: rightX,
            leftX: leftX,
            y: globalY
        });
        subMenuStack = stack;
    }

    function closeSubMenusFrom(depth) {
        if (subMenuStack.length > depth) {
            subMenuStack = subMenuStack.slice(0, depth);
        }
    }

    function closeAllSubMenus() {
        subMenuStack = [];
    }
}
