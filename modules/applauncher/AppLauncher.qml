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

    property bool wallpaperMode: searchText.startsWith('>')
    readonly property string searchText: search.searchField.text
    readonly property string filteredText: wallpaperMode ? searchText.substring(1) : searchText

    readonly property real maskLength: 0.2

    implicitWidth: wallpaperMode ? 600 : 450
    readonly property int listHeight: 200
    implicitHeight: columnLayout.implicitHeight

    Behavior on implicitHeight {
        BaseAnimation {}
    }

    Behavior on implicitWidth {
        BaseAnimation {}
    }

    state: wallpaperMode ? "wallpapers" : "apps"

    states: [
        State {
            name: "apps"
            PropertyChanges {
                target: appListLoader
                opacity: 1
                scale: 1
            }
            PropertyChanges {
                target: wallpaperListLoader
                opacity: 0
                scale: 0
            }
        },
        State {
            name: "wallpapers"
            PropertyChanges {
                target: appListLoader
                opacity: 0
                scale: 0
            }
            PropertyChanges {
                target: wallpaperListLoader
                opacity: 1
                scale: 1
            }
        }
    ]

    ColumnLayout {
        id: columnLayout

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        spacing: Config.style.spacing.large

        Item {
            Layout.fillWidth: true
            implicitHeight: root.listHeight

            property string searchText: search.searchField.text

            AnimatedLoader {
                id: appListLoader
                anchors {
                    fill: parent
                }

                sourceComponent: AppLauncherList {
                    searchText: root.filteredText
                    maskLength: root.maskLength
                }
            }

            AnimatedLoader {
                id: wallpaperListLoader
                anchors {
                    fill: parent
                }

                sourceComponent: WallpaperLauncherList {
                    searchText: root.filteredText
                    maskLength: root.maskLength
                }
            }
        }
        SearchField {
            id: search
            Layout.fillWidth: true

            searchField.Keys.forwardTo: [root]

            icon: root.wallpaperMode ? "wallpaper" : "search"

            Component.onCompleted: searchField.forceActiveFocus()
        }
    }

    Keys.onPressed: event => {
        const handlers = {
            [Qt.Key_Escape]: () => Global.launcherOpen = false,
            [Qt.Key_Up]: () => wallpaperMode ? false : appListLoader.item?.incrementCurrentIndex(),
            [Qt.Key_Down]: () => wallpaperMode ? false : appListLoader.item?.decrementCurrentIndex(),
            [Qt.Key_Left]: () => wallpaperMode ? wallpaperListLoader.item?.decrementCurrentIndex() : false,
            [Qt.Key_Right]: () => wallpaperMode ? wallpaperListLoader.item?.incrementCurrentIndex() : false,
            [Qt.Key_Return]: () => executeCurrentItem(),
            [Qt.Key_Enter]: () => executeCurrentItem()
        };

        const handler = handlers[event.key];
        if (handler) {
            const result = handler();
            event.accepted = result !== false;
        } else {
            event.accepted = false;
        }
    }

    function executeCurrentItem() {
        if (wallpaperMode) {
            wallpaperListLoader.item?.execute();
        } else {
            appListLoader.item?.execute();
        }
        Global.launcherOpen = false;
        return true;
    }

    onFocusStateChanged: {
        if (!focusState) {
            Global.launcherOpen = false;
        }
    }
}
