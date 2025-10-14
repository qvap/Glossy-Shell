pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.modules.applauncher
import qs.modules
import qs.components.containers
import qs.components
import qs.config

/* entry point for widgets (you call it drawer or smth)
/* it's such a bullshit, let me explain why:
/* when using the workaround with backdrop blur,
/* the only thing I could do is set alpha threshold
/* at some value like 0.1. It works fine for blurring,
/* but it also accounts shadow like it's not opaque and
/* blurs behind them anything too. So idk how to do it
/* and I just made two windows: one for blur stuff
/* and another for shadows. It keeps me tied up
/* UPD: I abandoned idea with blur :p*/

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
                    item: applauncher
                },
                Region {
                    item: bar
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

            ContainerWindow { // exclusion zone for bar
                name: "bar_exclusion"
                exclusiveZone: Config.style.barstyle.bar_chunkiness - 6
                implicitWidth: 1
                implicitHeight: 1
                mask: Region {}
                anchors {
                    bottom: true
                }
            }

            StyledPanelRectangle {
                x: 1400
                y: 50

                width: 400
                height: 400
            }

            Bar {id: bar} // decided to move it to main window so I can do more stuff :3

            AppLauncherWrapper {
                id: applauncher
                screen: modelData
            }
        }
    }
}