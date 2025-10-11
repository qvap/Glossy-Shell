pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland
import qs
import qs.components
import qs.config
import qs.components.containers

Item {
    id: root

    required property ShellScreen screen

    Component.onCompleted: {
        parent.widgetRegions?.push(mask)
    }

    implicitHeight: 0
    implicitWidth: launcher.implicitWidth
    visible: implicitHeight > 0

    clip: true

    SequentialAnimation {
        id: show
        running: false
        ScriptAction {
            script: {
                launcher.active = true
                launcher.visible = true
            }
        }
        PauseAnimation { duration: 100 }
        ParallelAnimation {
            BaseAnimation {
                duration: 250
                easing.type: Easing.OutQuad
                target: root
                property: "implicitHeight"
                to: launcher.implicitHeight * 1.2
            }
            BaseAnimation {
                duration: 250
                easing.type: Easing.OutQuad
                target: root
                property: "implicitWidth"
                to: launcher.implicitWidth * 0.8
            }
        }
        ParallelAnimation {
            BaseAnimation {
                duration: 500
                easing.type: Easing.OutQuad
                target: root
                property: "implicitHeight"
                to: launcher.implicitHeight
            }
            BaseAnimation {
                duration: 500
                easing.type: Easing.OutQuad
                target: root
                property: "implicitWidth"
                to: launcher.implicitWidth
            }
        }
    }

    SequentialAnimation {
        id: hide
        running: false
        ParallelAnimation {
            BaseAnimation {
                target: root
                property: "implicitHeight"
                to: 0
            }
            BaseAnimation {
                target: root
                property: "implicitWidth"
                to: 0
            }
        }
        ScriptAction {
            script: {
                launcher.visible = false
                launcher.active = false
            }
        }
    }

    anchors {
        bottom: parent.bottom
        bottomMargin: Config.style.bar_chunkiness + 10
        horizontalCenter: parent.horizontalCenter
    }

    Loader {
        id: launcher

        anchors {
            fill: parent
        }

        active: false
        visible: false

        sourceComponent: AppLauncher {
            screen: root.screen
        }
    }

    Connections {
        target: Global
        function onLauncherOpenChanged() {
            if (Global.launcherOpen) {
                show.start()
            } else {
                hide.start()
            }
        }
    }

    IpcHandler {
        target: "launcher"

        function toggle() {
            Global.launcherOpen = !Global.launcherOpen
        }
    }

    GlobalShortcut {
        appid: "glossy"
        name: "toggle_launcher"
        description: "Open / Close the App Launcher"
        onPressed: {
            Global.launcherOpen = !Global.launcherOpen
        }
    }
}
