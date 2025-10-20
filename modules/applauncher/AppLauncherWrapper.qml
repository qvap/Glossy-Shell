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
    required property bool focusState

    implicitHeight: launcher.implicitHeight
    implicitWidth: launcher.implicitWidth
    visible: implicitHeight > 0
    readonly property real implicitBottomMargin: Config.style.barstyle.bar_chunkiness * 1.2
    readonly property real implicitHiddenMargin: -50.0

    clip: true

    layer.enabled: true
    layer.effect: DropShadow {}

    transform: Scale {
        id: scaleTransform
        origin.x: root.width / 2
        origin.y: root.height / 2
        xScale: 0.0
        yScale: 0.0
    }

    opacity: 0.0

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
        ParallelAnimation {
            NumberAnimation {
                duration: Config.animation.durations.durationVeryLong
                easing.type: BezierSpline
                easing.bezierCurve: Config.animation.curves.bubblyHeight
                target: scaleTransform
                property: "xScale"
                to: 1.0
            }
            NumberAnimation {
                duration: Config.animation.durations.durationVeryLong
                easing.type: BezierSpline
                easing.bezierCurve: Config.animation.curves.bubblyWidth
                target: scaleTransform
                property: "yScale"
                to: 1.0
            }
            NumberAnimation {
                duration: Config.animation.durations.durationVeryLong
                easing.type: BezierSpline
                easing.bezierCurve: Config.animation.curves.bubblyWidth
                target: root
                property: "anchors.bottomMargin"
                to: implicitBottomMargin
            }
            BaseAnimation {
                duration: Config.animation.durations.durationShort
                easing.type: Easing.OutQuart
                target: root
                property: "opacity"
                to: 1.0
            }
        }
    }

    SequentialAnimation {
        id: hide
        running: false
        ScriptAction {
            script: {
                if (show.running) { show.stop() }
            }
        }
        ParallelAnimation {
            BaseAnimation {
                duration: Config.animation.durations.durationMedium
                easing.type: Easing.OutQuart
                target: scaleTransform
                property: "xScale"
                to: 0.0
            }
            BaseAnimation {
                duration: Config.animation.durations.durationMedium
                easing.type: Easing.OutQuart
                target: scaleTransform
                property: "yScale"
                to: 0.0
            }
            BaseAnimation {
                duration: Config.animation.durations.durationMedium
                easing.type: Easing.OutQuart
                target: root
                property: "anchors.bottomMargin"
                to: implicitHiddenMargin
            }
            BaseAnimation {
                duration: Config.animation.durations.durationMedium
                easing.type: Easing.OutQuart
                target: root
                property: "opacity"
                to: 0.0
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
        bottomMargin: implicitHiddenMargin
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
            focusState: root.focusState
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
}
