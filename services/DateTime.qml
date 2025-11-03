pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

/* im vewy shy and vewy sowwy that I yanked that from end-4's shell (,,>﹏<,,) */
/* reworked some parts tho */

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

    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: updateUptime()
    }

    function updateUptime() {
        fileUptime.reload()
        const textUptime = fileUptime.text()
        const uptimeSeconds = Number(textUptime.split(" ")[0] ?? 0)

        const days = Math.floor(uptimeSeconds / 86400)
        const hours = Math.floor((uptimeSeconds % 86400) / 3600)
        const minutes = Math.floor((uptimeSeconds % 3600) / 60)

        const parts = [
            days > 0 ? `${days}d` : "",
            hours > 0 ? `${hours}h` : "",
            minutes >= 0 || days === 0 && hours === 0 ? `${minutes}m` : ""
        ].filter(Boolean)

        uptime = parts.join(", ")
    }

    FileView {
        id: fileUptime
        path: "/proc/uptime"
    }
}
