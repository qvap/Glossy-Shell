import QtQuick
import Quickshell
import qs.components
import qs.services
import qs.config

Item {
    id: root

    anchors {
        top: parent.top
        right: parent.right
        topMargin: Config.style.spacing.standart
        rightMargin: Config.style.spacing.standart
    }

    width: 370
    height: parent.height

    ListView {
        anchors {
            fill: parent
        }
        spacing: Config.style.spacing.standart

        verticalLayoutDirection: ListView.TopToBottom

        model: Notifications.activeNotifications

        delegate: NotificationPopup {
            anchors {
                right: parent ? parent.right : undefined
            }
            onCloseRequested: {
                Notifications.closeNotification(id);
            }

            onActionClicked: actionKey => {
                Notifications.invokeAction(id, actionKey);
            }
        }

        add: Transition {
            BaseAnimation {
                property: "y"
                from: -100.0
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Config.animation.curves.emphasizedDecel
                duration: Config.animation.duration.large
            }
        }
    }

    Component.onCompleted: {
        console.log("[NotificationCenter] Initialized");
        console.log("[NotificationCenter] Parent: ", parent);
        console.log("[NotificationCenter] Size: ", width, "x", height);
    }
}
