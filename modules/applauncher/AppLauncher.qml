pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import qs
import qs.components
import qs.config
import qs.services

/* cool! why so buggy tho */

Item {
    id: root
    
    required property ShellScreen screen
    required property bool focusState

    implicitWidth: 450
    implicitHeight: columnLayout.implicitHeight

    Behavior on implicitHeight {
        BaseAnimation {}
    }

    ColumnLayout {
        id: columnLayout

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        spacing: 14

        implicitHeight: appList.implicitHeight + searchBackground.implicitHeight + spacing

        AppLauncherList {
            id: appList
            Layout.fillWidth: true
            implicitHeight: 200
            searchText: search.text
        }

        StyledPanelRectangle {
            id: searchBackground

            Layout.fillWidth: true

            implicitHeight: 45

            StyledTextField {
                id: search
                
                anchors {
                    fill: parent
                    margins: 10
                }
            }
        }
    }

    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: maskRect
    }

    Rectangle {
        id: maskRect

        layer.enabled: true
        visible: false

        anchors {
            fill: parent
        }
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(0, 0, 0, 0) }
            GradientStop { position: 0.2; color: Qt.rgba(0, 0, 0, 1) }
        }
    }

    Connections {
        target: root
        function onFocusStateChanged() {
            if (!root.focusState) {
                Global.launcherOpen = false;
            }
        }
    }

    Keys.onPressed: (event) => {
        switch (event.key) {
            case Qt.Key_Escape:
                Global.launcherOpen = false;
                break;
            case Qt.Key_Up:
                appList.incrementCurrentIndex();
                break;
            case Qt.Key_Down:
                appList.decrementCurrentIndex();
                break;
            case Qt.Key_Return || Qt.Key_Enter():
                appList.execute();
                Global.launcherOpen = false;
                break;
            default:
                event.accepted = false;
                return;
        }
        event.accepted = true;
    }

    Component.onCompleted: {
        search.forceActiveFocus()
    }
}