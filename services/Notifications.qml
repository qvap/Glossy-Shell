pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    property NotificationServer notificationServer: NotificationServer {}
    property list<Notification> currentNotifications: []

    function addNotif(notif: Notification): void {
        console.log(notif);
        root.currentNotifications.push(notif);
    }

    Connections {
        target: root.notificationServer
        function onNotification(notif) {
            root.addNotif(notif);
        }
    }
}
