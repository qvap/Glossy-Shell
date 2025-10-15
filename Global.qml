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
}