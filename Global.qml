pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

/* global states or smth */

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
}
