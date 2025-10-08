pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.modules


Variants {
    model: Quickshell.screens
    Scope {
        id: scope
        required property ShellScreen modelData

        PanelWindow {
            screen: scope.modelData
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace : "quickshell:screencorners"
            color: "transparent"
            mask: Region {}
            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }
            ScreenCornersDrawer {}
        }
    }
}