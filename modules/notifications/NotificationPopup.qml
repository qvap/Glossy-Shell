pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.components
import qs.config
import qs.services

StyledPanelRectangle {
    id: root

    signal actionClicked(string actionKey)
    signal closeRequested

    required property int id
    required property string appName
    required property string summary
    required property string body
    required property int urgency
    required property int timestamp
    required property int timeout
    required property var actions
    required property string image
    required property string appIcon
    required property bool isRead
    required property bool hasActions

    width: mainColumn.width + Config.style.padding.standart * 2
    height: mainColumn.height + Config.style.padding.standart * 2

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

    Component.onCompleted: {
        console.log("[NotificationPopup] Created:", appName, "-", summary);
        showAnimation.start();
    }

    ParallelAnimation {
        id: showAnimation
        running: false

        NumberAnimation {
            duration: Config.animation.duration.veryLarge
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Config.animation.curves.bubblyWidth
            target: scaleTransform
            property: "xScale"
            from: 0.0
            to: 1.0
        }

        NumberAnimation {
            duration: Config.animation.duration.veryLarge
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Config.animation.curves.bubblyHeight
            target: scaleTransform
            property: "yScale"
            from: 0.0
            to: 1.0
        }

        NumberAnimation {
            duration: Config.animation.duration.small
            easing.type: Easing.OutQuart
            target: root
            property: "opacity"
            from: 0.0
            to: 1.0
        }
    }

    SequentialAnimation {
        id: hideAnimation
        running: false

        ParallelAnimation {
            NumberAnimation {
                duration: Config.animation.duration.normal
                easing.type: Easing.InQuart
                target: scaleTransform
                property: "xScale"
                to: 0.0
            }

            NumberAnimation {
                duration: Config.animation.duration.normal
                easing.type: Easing.InQuart
                target: scaleTransform
                property: "yScale"
                to: 0.0
            }

            NumberAnimation {
                duration: Config.animation.duration.normal
                easing.type: Easing.InQuart
                target: root
                property: "opacity"
                to: 0.0
            }
        }

        ScriptAction {
            script: root.closeRequested()
        }
    }

    Timer {
        id: autoCloseTimer
        interval: root.timeout
        running: root.timeout > 0
        repeat: false
        onTriggered: {
            console.log("[NotificationPopup] Auto-closing:", root.id);
            hideAnimation.start();
        }
    }

    ColumnLayout {
        id: mainColumn
        anchors {
            centerIn: parent
        }
        spacing: Config.style.spacing.verySmall
        width: 350

        RowLayout {
            Layout.fillWidth: true

            LazyLoader {
                active: root.appIcon !== ""
                component: Image {
                    id: appIconImage
                    Layout.preferredWidth: 24
                    Layout.preferredHeight: 24
                    source: root.appIcon
                    fillMode: Image.PreserveAspectFit

                    onStatusChanged: {
                        if (status === Image.Error) {
                            console.warn("[NotificationPopup] Failed to load app icon:", root.appIcon);
                        }
                    }
                }
            }

            StyledText {
                Layout.fillWidth: true
                text: root.appName
                font {
                    pixelSize: Config.style.fonts.smallSize
                    bold: true
                }
                elide: Text.ElideRight
                color: "white"
                opacity: 0.75
            }

            StyledText {
                Layout.alignment: Qt.AlignRight
                text: DateTime.time + " ✧"
                font {
                    pixelSize: Config.style.fonts.smallSize
                }
                opacity: 0.5
                color: "white"
            }
        }

        StyledText {
            Layout.fillWidth: true
            text: root.summary
            wrapMode: Text.Wrap
            font {
                bold: true
                pixelSize: Config.style.fonts.standartSize
            }
            color: "white"
        }

        StyledText {
            Layout.fillWidth: true
            text: root.body
            wrapMode: Text.Wrap
            opacity: 0.8
            font.pixelSize: Config.style.fonts.smallSize
            visible: text.length > 0
            maximumLineCount: 5
            elide: Text.ElideRight
            color: "white"
        }

        LazyLoader {
            active: root.image !== ""
            component: Image {
                id: notifImage
                Layout.fillWidth: true
                Layout.preferredHeight: 150
                source: root.image
                fillMode: Image.PreserveAspectFit

                onStatusChanged: {
                    if (status === Image.Error) {
                        console.warn("[NotificationPopup] Failed to load image:", root.image);
                        visible = false;
                    }
                }
            }
        }

        Flow {
            Layout.fillWidth: true
            spacing: Config.style.spacing.verySmall
            visible: root.hasActions

            Repeater {
                model: root.actions

                StyledRectangle {
                    required property string key
                    required property string label

                    width: Math.min(actionText.implicitWidth + Config.style.padding.standart * 2, root.width - Config.style.padding.standart * 2)
                    height: 32
                    radius: Config.style.rounding.small

                    StyledText {
                        id: actionText
                        anchors.centerIn: parent
                        text: parent.label
                        font.pixelSize: Config.style.fonts.smallSize
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onClicked: {
                            console.log("[NotificationPopup] Action clicked:", parent.key);
                            autoCloseTimer.stop();
                            root.actionClicked(parent.key);
                            hideAnimation.start();
                        }

                        onPressed: parent.opacity = 0.7
                        onReleased: parent.opacity = 1.0
                        onEntered: parent.opacity = 0.9
                        onExited: parent.opacity = 1.0
                    }
                }
            }
        }
    }
}
