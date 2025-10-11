pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.modules.applauncher

/* Entry point for widgets (you call it drawer or smth)*/

Variants {

    model: Quickshell.screens

    PanelWindow {
        id: root

        required property ShellScreen modelData
        property list<Region> widgetRegions: [
            /* could be better with dynamic list appends
            and reactive bindings, but I have no budget
            for this */
            Region {
                item: applauncher
            }
        ]

        color: "transparent"

        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

        HyprlandFocusGrab {
            id: focusGrab
            windows: [root]
            active: Global.launcherOpen
        }

        anchors {
            left: true
            right: true
            top: true
            bottom: true
        }

        mask: Region {regions: widgetRegions}

        AppLauncherWrapper {
            id: applauncher
            screen: modelData
        }
    }
}