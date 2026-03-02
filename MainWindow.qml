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
// SOME ELEMENTS ARE VIBE_CODED // SUBJECT TO REVIEW

Scope {

    Variants {

        model: Quickshell.screens

        ContainerWindow {
            id: root

            name: "main"

            required property ShellScreen modelData

            function buildMaskRegions(): list<Region> {
                let regions = [barRegion, applauncherRegion, trayPopOutRegion];
                // force dependency on stack length so this re-evaluates
                void (Global.subMenuStack.length);
                for (let i = 0; i < subMenuRepeater.count; i++) {
                    let item = subMenuRepeater.itemAt(i);
                    if (item && item.visible) {
                        regions.push(item.inputRegion);
                    }
                }
                return regions;
            }

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
                regions: root.buildMaskRegions()
            }

            Region {
                id: barRegion
                item: bar
            }

            Region {
                id: applauncherRegion
                item: applauncher
            }

            Region {
                id: trayPopOutRegion
                x: trayPopOut.x
                y: trayPopOut.y
                width: trayPopOut.visible ? trayPopOut.width : 0
                height: trayPopOut.visible ? trayPopOut.height : 0
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

            Repeater {
                id: subMenuRepeater
                model: Global.subMenuStack

                delegate: SubMenuPopOut {
                    id: subMenuDelegate

                    required property var modelData
                    required property int index

                    property Region inputRegion: Region {
                        x: subMenuDelegate.x
                        y: subMenuDelegate.y
                        width: subMenuDelegate.visible ? subMenuDelegate.width : 0
                        height: subMenuDelegate.visible ? subMenuDelegate.height : 0
                    }

                    menuEntry: modelData.menu
                    depth: index
                    targetX: modelData.rightX
                    targetY: modelData.y
                    sideAltX: modelData.leftX
                }
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
