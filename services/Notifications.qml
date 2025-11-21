pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    property NotificationServer notificationServer: NotificationServer {}

    property ListModel activeNotifications: ListModel {}
    property ListModel notificationHistory: ListModel {}
    property var notificationMap: ({})

    property bool doNotDisturb: false
    property int maxActiveNotifications: 5
    property int defaultTimeout: 5000
    property bool showCriticalWhenDnd: true
    property bool enableSounds: true
    property int unreadCount: 0

    signal notificationAdded(var notification)
    signal notificationRemoved(int id)
    signal notificationClosed(int id, int reason)
    signal notificationActionInvoked(int id, string action)
    signal allCleared

    function addNotification(notif: Notification): void {
        if (doNotDisturb && notif.urgency !== Notification.Critical && !showCriticalWhenDnd) {
            addToHistory(notif);
            notif.close();
            return;
        }

        if (activeNotifications.count >= maxActiveNotifications) {
            removeOldest();
        }

        notificationMap[notif.id] = notif;

        const actionsArray = parseActions(notif.actions);

        const timeout = notif.expireTimeout > 0 ? notif.expireTimeout : (notif.expireTimeout === 0 ? -1 : defaultTimeout);

        activeNotifications.append({
            "notification": notif,
            "id": notif.id,
            "appName": notif.appName,
            "summary": notif.summary,
            "body": notif.body,
            "urgency": notif.urgency,
            "timestamp": Date.now(),
            "timeout": timeout,
            "actions": actionsArray,
            "image": notif.image,
            "appIcon": notif.appIcon,
            "isRead": false,
            "hasActions": actionsArray.length > 0
        });

        addToHistory(notif);

        unreadCount++;
        notificationAdded(notif);

        setupNotificationConnections(notif);

        console.log(`[Notifications] Added: ${notif.appName} - ${notif.summary}`);
    }

    function setupNotificationConnections(notif: Notification): void {
        notif.closed.connect(function (reason) {
            root.handleNotificationClosed(notif.id, reason);
        });
    }

    function handleNotificationClosed(id: int, reason: int): void {
        console.log(`[Notifications] Closed: ${id}, reason ${reason}`);

        removeNotification(id);

        delete notificationMap[id];

        notificationClosed(id, reason);
    }

    function parseActions(actionsRaw: var): var {
        const result = [];
        if (!actionsRaw || actionsRaw.length === 0) {
            return result;
        }

        for (let i = 0; i < actionsRaw.length; i += 2) {
            if (i + 1 < actionsRaw.length) {
                result.push({
                    "key": actionsRaw[i],
                    "label": actionsRaw[i + 1]
                });
            }
        }

        return result;
    }

    function invokeAction(id: int, actionKey: string): void {
        const notif = notificationMap[id];
        if (notif) {
            console.log(`[Notifications] Invoking action: ${actionKey} on notification ${id}`);
            notif.invokeAction(actionKey);
            notificationActionInvoked(id, actionKey);
        } else {
            console.warn(`[Notifications] Cannot invoke action: notification ${id} not found`);
        }
    }

    function closeNotification(id: int): void {
        console.log(`[Notifications] Closing notification: ${id}`);

        removeNotification(id);

        const notif = notificationMap[id];
        if (notif) {
            try {
                notif.closed.disconnect(root.handleNotificationClosed);
            } catch (e) {}
            delete notificationMap[id];
        }

        notificationRemoved(id);
    }

    function removeNotification(id: int): void {
        for (let i = 0; i < activeNotifications.count; i++) {
            if (activeNotifications.get(i).id === id) {
                const notif = activeNotifications.get(i);
                if (!notif.isRead) {
                    unreadCount = Math.max(0, unreadCount - 1);
                }
                activeNotifications.remove(i);
                notificationRemoved(id);
                return;
            }
        }
    }

    function removeOldest(): void {
        if (activeNotifications.count > 0) {
            const oldest = activeNotifications.get(0);
            closeNotification(oldest.id);
        }
    }

    function clearAll(): void {
        for (let i = 0; i < activeNotifications.count; i++) {
            const notif = activeNotifications.get(i);
            const notifObj = notificationMap[notif.id];
            if (notifObj) {
                notifObj.close();
            }
            delete notificationMap[notif.id];
        }

        activeNotifications.clear();
        unreadCount = 0;
        allCleared();
    }

    function markAsRead(id: int): void {
        for (let i = 0; i < activeNotifications.count; i++) {
            const notif = activeNotifications.get(i);
            if (notif.id === id && !notif.isRead) {
                activeNotifications.setProperty(i, "isRead", true);
                unreadCount = Math.max(0, unreadCount - 1);
                return;
            }
        }
    }

    function addToHistory(notif: Notification): void {
        notificationHistory.insert(0, {
            "id": notif.id,
            "appName": notif.appName,
            "summary": notif.summary,
            "body": notif.body,
            "urgency": notif.urgency,
            "timestamp": Date.now(),
            "image": notif.image,
            "appIcon": notif.appIcon
        });

        while (notificationHistory.count > 100) {
            notificationHistory.remove(notificationHistory.count - 1);
        }
    }

    function clearHistory(): void {
        notificationHistory.clear();
    }

    function getNotificationsByApp(appName: string): var {
        const result = [];
        for (let i = 0; i < notificationHistory.count; i++) {
            const notif = notificationHistory.get(i);
            if (notif.appName === appName) {
                result.push(notif);
            }
        }
        return result;
    }

    function getAppStatistics(): var {
        const stats = {};
        for (let i = 0; i < notificationHistory.count; i++) {
            const notif = notificationHistory.get(i);
            if (!stats[notif.appName]) {
                stats[notif.appName] = 0;
            }
            stats[notif.appName]++;
        }
        return stats;
    }

    Connections {
        target: root.notificationServer

        function onNotification(notif: Notification): void {
            root.addNotification(notif);
        }
    }
}
