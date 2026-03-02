pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.components
import qs.components.containers
import qs.config
import qs

// ENTIRELY VIBE_CODED // SUBJECT TO REVIEW

PopOut {
    id: subMenuRoot

    required property var menuEntry
    required property int depth

    shown: true
    interactive: true
    anchorMode: "side"
    width: Math.max(subMenuContent.implicitWidth, 150) + Config.style.padding.small * 2
    height: subMenuContent.implicitHeight + Config.style.padding.small * 2

    onEntered: {
        Global._popOutSeq++;
        Global._subMenuSeq++;
    }
    onExited: {
        subMenuHideTimer._seq = Global._subMenuSeq;
        subMenuHideTimer.restart();
        popOutHideTimer._seq = Global._popOutSeq;
        popOutHideTimer.restart();
    }

    Timer {
        id: subMenuHideTimer
        property int _seq: 0
        interval: 300
        onTriggered: {
            if (_seq === Global._subMenuSeq) {
                Global.closeSubMenusFrom(subMenuRoot.depth);
            }
        }
    }

    Timer {
        id: popOutHideTimer
        property int _seq: 0
        interval: 300
        onTriggered: {
            if (_seq === Global._popOutSeq) {
                Global.closeAllSubMenus();
                Global.popOutVisible = false;
            }
        }
    }

    QsMenuOpener {
        id: subMenuOpener
        menu: subMenuRoot.menuEntry
    }

    ColumnLayout {
        id: subMenuContent
        spacing: Config.style.spacing.verySmall

        Repeater {
            model: subMenuOpener.children

            delegate: Item {
                id: subMenuEntryDelegate

                required property QsMenuEntry modelData
                required property int index

                Layout.fillWidth: true
                Layout.preferredHeight: modelData.isSeparator ? separatorLine.height : entryRow.implicitHeight + Config.style.padding.verySmall * 2
                implicitWidth: modelData.isSeparator ? 0 : entryRow.implicitWidth + Config.style.padding.verySmall * 2

                Rectangle {
                    id: separatorLine
                    anchors.centerIn: parent
                    width: parent.width
                    height: 1
                    color: Qt.lighter(Colors.primary, 1.6)
                    opacity: 0.3
                    visible: subMenuEntryDelegate.modelData.isSeparator
                }

                Rectangle {
                    id: entryBackground
                    anchors.fill: parent
                    radius: Config.style.rounding.small * 0.5
                    color: Qt.lighter(Colors.primary, 1.6)
                    opacity: entryMouseArea.containsMouse && subMenuEntryDelegate.modelData.enabled ? 0.15 : 0
                    visible: !subMenuEntryDelegate.modelData.isSeparator

                    Behavior on opacity {
                        NumberAnimation {
                            duration: Config.animation.duration.small
                            easing.type: Easing.OutQuart
                        }
                    }
                }

                RowLayout {
                    id: entryRow
                    anchors {
                        left: parent.left
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                        leftMargin: Config.style.padding.verySmall
                        rightMargin: Config.style.padding.verySmall
                    }
                    spacing: Config.style.spacing.verySmall
                    visible: !subMenuEntryDelegate.modelData.isSeparator

                    StyledText {
                        Layout.fillWidth: true
                        text: subMenuEntryDelegate.modelData.text
                        wrapping: false
                        font.pixelSize: Config.style.fonts.smallSize
                        color: subMenuEntryDelegate.modelData.enabled ? "white" : Qt.rgba(1, 1, 1, 0.4)
                    }

                    StyledText {
                        visible: subMenuEntryDelegate.modelData.hasChildren
                        text: "›"
                        font.pixelSize: Config.style.fonts.smallSize
                        color: "white"
                        opacity: 0.5
                    }
                }

                MouseArea {
                    id: entryMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    enabled: !subMenuEntryDelegate.modelData.isSeparator
                    cursorShape: (subMenuEntryDelegate.modelData.enabled && !subMenuEntryDelegate.modelData.isSeparator) ? Qt.PointingHandCursor : Qt.ArrowCursor

                    onContainsMouseChanged: {
                        if (containsMouse) {
                            Global._popOutSeq++;
                            Global._subMenuSeq++;
                            if (subMenuEntryDelegate.modelData.hasChildren) {
                                const mappedRight = subMenuEntryDelegate.mapToItem(null, subMenuEntryDelegate.width, subMenuEntryDelegate.height / 2);
                                const mappedLeft = subMenuEntryDelegate.mapToItem(null, 0, subMenuEntryDelegate.height / 2);
                                Global.openSubMenu(subMenuEntryDelegate.modelData, mappedRight.x + Config.style.spacing.small, mappedLeft.x - Config.style.spacing.small, mappedRight.y, subMenuRoot.depth + 1);
                            } else {
                                Global.closeSubMenusFrom(subMenuRoot.depth + 1);
                            }
                        }
                    }

                    onClicked: {
                        if (subMenuEntryDelegate.modelData.enabled && !subMenuEntryDelegate.modelData.hasChildren) {
                            subMenuEntryDelegate.modelData.triggered();
                            Global.closeAllSubMenus();
                            Global.popOutVisible = false;
                        }
                    }
                }
            }
        }
    }
}
