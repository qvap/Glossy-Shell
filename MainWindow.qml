pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.modules.applauncher
import qs.modules
import qs.components.containers
import qs.components
import qs.services
import qs.config

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
