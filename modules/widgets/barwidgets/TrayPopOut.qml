import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.components
import qs.components.containers
import qs.config
import qs

// ENTIRELY VIBE_CODED // SUBJECT TO REVIEW

PopOut {
    id: trayPopOut
    shown: Global.popOutVisible
    targetX: Global.popOutX
    targetY: Global.popOutY
    interactive: true
    width: _frozen ? _frozenWidth : _liveWidth
    height: _frozen ? _frozenHeight : _liveHeight

    property real _liveWidth: Math.max(popOutContent.implicitWidth, 150) + Config.style.padding.small * 2
    property real _liveHeight: popOutContent.implicitHeight + Config.style.padding.small * 2

    property bool _frozen: false
    property real _frozenWidth: 0
    property real _frozenHeight: 0

    property string _prevTitle: ""

    function _freeze() {
        _frozenWidth = width;
        _frozenHeight = height;
        _frozen = true;
    }

    function _unfreeze() {
        _frozen = false;
    }

    onEntered: {
        Global._popOutSeq++;
    }
    onExited: {
        popOutAreaHideTimer._seq = Global._popOutSeq;
        popOutAreaHideTimer.restart();
    }

    onShownChanged: {
        if (!shown) {
            Global.closeAllSubMenus();
        }
    }

    Timer {
        id: popOutAreaHideTimer
        property int _seq: 0
        interval: 300
        onTriggered: {
            if (_seq === Global._popOutSeq)
                Global.popOutVisible = false;
        }
    }

    QsMenuOpener {
        id: menuOpener
        menu: Global.popOutMenu
    }

    ColumnLayout {
        id: popOutContent
        spacing: Config.style.spacing.verySmall

        opacity: 1

        Connections {
            target: Global
            function onPopOutTitleChanged() {
                if (trayPopOut.shown && trayPopOut._prevTitle !== "" && trayPopOut._prevTitle !== Global.popOutTitle) {
                    trayPopOut._freeze();
                    Global.closeAllSubMenus();
                    popOutContent.opacity = 0;
                    contentSettleTimer.restart();
                }
                trayPopOut._prevTitle = Global.popOutTitle;
            }
        }

        Timer {
            id: contentSettleTimer
            interval: 50
            onTriggered: {
                trayPopOut._unfreeze();
                fadeInAnimation.start();
            }
        }

        NumberAnimation {
            id: fadeInAnimation
            target: popOutContent
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: Config.animation.duration.verySmall
            easing.type: Easing.OutQuart
        }

        StyledText {
            Layout.fillWidth: true
            text: Global.popOutTitle
            font.pixelSize: Config.style.fonts.standartSize
            font.bold: true
            color: "white"
            visible: text.length > 0
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: Qt.lighter(Colors.primary, 1.6)
            opacity: 0.3
            visible: Global.popOutTitle.length > 0 && menuOpener.children.count > 0
        }

        Repeater {
            model: menuOpener.children

            delegate: Item {
                id: menuEntryDelegate

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
                    visible: menuEntryDelegate.modelData.isSeparator
                }

                Rectangle {
                    id: entryBackground
                    anchors.fill: parent
                    radius: Config.style.rounding.small * 0.5
                    color: Qt.lighter(Colors.primary, 1.6)
                    opacity: entryMouseArea.containsMouse && menuEntryDelegate.modelData.enabled ? 0.15 : 0
                    visible: !menuEntryDelegate.modelData.isSeparator

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
                    visible: !menuEntryDelegate.modelData.isSeparator

                    StyledText {
                        Layout.fillWidth: true
                        text: menuEntryDelegate.modelData.text
                        wrapping: false
                        font.pixelSize: Config.style.fonts.smallSize
                        color: menuEntryDelegate.modelData.enabled ? "white" : Qt.rgba(1, 1, 1, 0.4)
                    }

                    StyledText {
                        visible: menuEntryDelegate.modelData.hasChildren
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
                    enabled: !menuEntryDelegate.modelData.isSeparator && popOutContent.opacity > 0
                    cursorShape: (menuEntryDelegate.modelData.enabled && !menuEntryDelegate.modelData.isSeparator) ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onContainsMouseChanged: {
                        if (containsMouse) {
                            Global._popOutSeq++;
                            if (menuEntryDelegate.modelData.hasChildren) {
                                const mappedRight = menuEntryDelegate.mapToItem(null, menuEntryDelegate.width, menuEntryDelegate.height / 2);
                                const mappedLeft = menuEntryDelegate.mapToItem(null, 0, menuEntryDelegate.height / 2);
                                Global.openSubMenu(menuEntryDelegate.modelData, mappedRight.x + Config.style.spacing.small, mappedLeft.x - Config.style.spacing.small, mappedRight.y, 0);
                            } else {
                                Global.closeAllSubMenus();
                            }
                        }
                    }
                    onClicked: event => {
                        if (menuEntryDelegate.modelData.enabled && !menuEntryDelegate.modelData.hasChildren) {
                            menuEntryDelegate.modelData.triggered();
                            Global.closeAllSubMenus();
                            Global.popOutVisible = false;
                        }
                    }
                }
            }
        }
    }
}
