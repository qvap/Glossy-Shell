pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Layouts
import qs.modules.applauncher
import qs.modules.notifications
import qs.modules.widgets.barwidgets
import qs.modules
import qs.components.containers
import qs.components
import qs.services
import qs.config
import qs

/* entry point for widgets (you call it drawer or smth) */

Scope {

    Variants {

        model: Quickshell.screens

        ContainerWindow {
            id: root

            name: "main"

            required property ShellScreen modelData
            property list<Region> widgetRegions: [
                /* could be better with dynamic list appends
                and reactive bindings, but I have no budget
                for this */
                Region {
                    item: bar
                },
                Region {
                    item: applauncher
                },
                Region {
                    x: trayPopOut.x
                    y: trayPopOut.y
                    width: trayPopOut.visible ? trayPopOut.width : 0
                    height: trayPopOut.visible ? trayPopOut.height : 0
                }
            ]

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

            mask: Region {
                regions: widgetRegions
            }

            ContainerWindow {
                // exclusion zone for bar
                name: "bar_exclusion"
                exclusiveZone: Global.barOpen ? Config.style.barstyle.bar_chunkiness * 0.9 : 0
                implicitWidth: 1
                implicitHeight: 1
                mask: Region {}
                anchors {
                    bottom: true
                }
            }

            Bar {
                id: bar
            } // decided to move it to main window so I can do more stuff :3

            NotificationCenter {}

            TrayPopOut {
                id: trayPopOut
            }

            AppLauncherWrapper {
                id: applauncher
                screen: modelData
                focusState: focusGrab.active
            }
        }
    }

    GlobalShortcut {
        appid: "glossy"
        name: "toggle_launcher"
        description: "Open / Close the App Launcher"
        onPressed: {
            Global.launcherOpen = !Global.launcherOpen;
        }
    }
}
