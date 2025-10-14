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

/* бипки */

Item {
    id: root

    required property ShellScreen screen

    implicitHeight: 0
    implicitWidth: launcher.implicitWidth
    visible: implicitHeight > 0

    clip: true

    SequentialAnimation {
        id: show
        running: false
        ScriptAction {
            script: {
                if (hide.running) { hide.stop() }
                launcher.active = true
                launcher.visible = true
            }
        }
        PauseAnimation { duration: 100 }
        BaseAnimation {
            duration: 400
            easing.type: Easing.OutQuart
            target: root
            property: "implicitHeight"
            to: launcher.implicitWidth
        }
    }

    SequentialAnimation {
        id: hide
        running: false
        BaseAnimation {
            duration: 400
            easing.type: Easing.OutQuart
            target: root
            property: "implicitHeight"
            to: 0
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
        bottomMargin: 60
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
