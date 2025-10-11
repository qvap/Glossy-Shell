pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

/* im vewy shy and vewy sowwy that I yanked that from end-4's shell (,,>﹏<,,) */

Singleton {
    property var clock: SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
    property string time: Qt.locale().toString(clock.date, "hh:mm")
    property string shortDate: Qt.locale().toString(clock.date, "dd/MM")
    property string date: Qt.locale().toString(clock.date, "dddd, dd/MM")
    property string collapsedCalendarFormat: Qt.locale().toString(clock.date, "dd MMMM yyyy")
    property string uptime: "0h, 0m"

    Timer { //toDo: rework clock to use quickshell services
        interval: 10
        running: true
        repeat: true
        onTriggered: {
            fileUptime.reload()
            const textUptime = fileUptime.text()
            const uptimeSeconds = Number(textUptime.split(" ")[0] ?? 0)

            const days = Math.floor(uptimeSeconds / 86400)
            const hours = Math.floor((uptimeSeconds % 86400) / 3600)
            const minutes = Math.floor((uptimeSeconds % 3600) / 60)

            let formatted = ""
            if (days > 0) formatted += `${days}d`
            if (hours > 0) formatted += `${formatted ? ", " : ""}${hours}h`
            if (minutes > 0 || !formatted) formatted += `${formatted ? ", " : ""}${minutes}m`
            uptime = formatted
            interval = 3000
        }
    }

    FileView {
        id: fileUptime
        path: "/proc/uptime"
    }
}