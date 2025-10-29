pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import qs
import qs.components
import qs.services
import qs.config

/* cool! why so buggy tho */

Item {
    id: root

    required property ShellScreen screen
    required property bool focusState
    property bool wallpaperMode: false
    readonly property real maskLength: 0.2

    implicitWidth: wallpaperMode ? 600 : 450
    implicitHeight: columnLayout.implicitHeight

    Behavior on implicitHeight {
        BaseAnimation {}
    }

    Behavior on implicitWidth {
        BaseAnimation {}
    }

    ColumnLayout {
        id: columnLayout

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        spacing: Config.style.spacing.large

        implicitHeight: listContainer.implicitHeight + searchBackground.implicitHeight + spacing

        Item {
            id: listContainer
            Layout.fillWidth: true
            implicitHeight: 200

            property string searchText: search.text

            Loader {
                id: appListLoader
                anchors {
                    fill: parent
                }
                asynchronous: false

                opacity: root.wallpaperMode ? 0 : 1
                scale: root.wallpaperMode ? 0 : 1
                visible: opacity > 0

                sourceComponent: AppLauncherList {
                    searchText: listContainer.searchText
                    maskLength: root.maskLength
                }

                Behavior on opacity {
                    BaseAnimation {}
                }

                Behavior on scale {
                    BaseAnimation {}
                }
            }

            Loader {
                id: wallpaperListLoader
                anchors {
                    fill: parent
                }
                asynchronous: false

                opacity: root.wallpaperMode ? 1 : 0
                scale: root.wallpaperMode ? 1 : 0
                visible: opacity > 0

                sourceComponent: WallpaperLauncherList {
                    searchText: listContainer.searchText
                    maskLength: root.maskLength
                }

                Behavior on opacity {
                    BaseAnimation {}
                }

                Behavior on scale {
                    BaseAnimation {}
                }
            }
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

                Keys.forwardTo: [root]

                onTextEdited: {
                    root.wallpaperMode = text.startsWith('>');
                    listContainer.searchText = text.startsWith('>') ? text.substring(1) : text;
                }
            }
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

    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_Escape:
            Global.launcherOpen = false;
            break;
        case Qt.Key_Up:
            if (!root.wallpaperMode) {
                appListLoader.item?.incrementCurrentIndex();
            } else {
                event.accepted = false;
                return;
            }
            break;
        case Qt.Key_Down:
            if (!root.wallpaperMode) {
                appListLoader.item?.decrementCurrentIndex();
            } else {
                event.accepted = false;
                return;
            }
            break;
        case Qt.Key_Left: {
            if (root.wallpaperMode) {
                wallpaperListLoader.item?.decrementCurrentIndex();
            } else {
                event.accepted = false;
                return;
            }
            break;
        }
        case Qt.Key_Right: {
            if (root.wallpaperMode) {
                wallpaperListLoader.item?.incrementCurrentIndex();
            } else {
                event.accepted = false;
                return;
            }
            break;
        }
        case Qt.Key_Return || Qt.Key_Enter:
            if (root.wallpaperMode) {
                wallpaperListLoader.item?.execute();
            } else {
                appListLoader.item?.execute();
            }
            Global.launcherOpen = false;
            break;
        default:
            event.accepted = false;
            return;
        }
        event.accepted = true;
    }
    Component.onCompleted: {
        search.forceActiveFocus();
    }
}
