import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import qs.config
import qs.services
import qs.components

/* the only thing thats cool in this shell */

Item {
    id: root
    property int padding: 10
    property bool showDate: Config.style.barstyle.show_date_in_clock_widget
    implicitWidth: rowLayout.implicitWidth + padding * 2
    implicitHeight: Config.style.barstyle.bar_chunkiness - padding * 2

    property bool hovered: false

    Timer {
        id:hoverTimer
        onTriggered: {
            root.hovered = false;
        }
    }

    readonly property var batteryIcons: [
        { "level": 5, "icon": "battery_android_alert" },
        { "level": 20, "icon": "battery_android_frame_1" },
        { "level": 30, "icon": "battery_android_frame_2" },
        { "level": 40, "icon": "battery_android_frame_3" },
        { "level": 50, "icon": "battery_android_frame_4" },
        { "level": 70, "icon": "battery_android_frame_5" },
        { "level": 90, "icon": "battery_android_frame_6" },
        { "level": 101, "icon": "battery_android_frame_full" }
    ]

    function getBatteryIcon(percentage) {
        for (const item of batteryIcons) {
            if (percentage < item.level) {
                return item.icon;
            }
        }
        return batteryIcons[batteryIcons.length - 1].icon;
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: {
            if (hoverTimer.running) {
                hoverTimer.stop()
            }
            hoverTimer.start()
        }
    }

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 0

        StyledText {
            wrapping: false
            font.bold: true
            color: "white"
            text: (UPower.displayDevice.isLaptopBattery || UPower.onBattery) ? Math.round(UPower.displayDevice.percentage * 100) + "%" : "😝"
            opacity: hovered ? 1 : 0
            Layout.preferredWidth: hovered ? implicitWidth : 0
        }

        StyledText {
            wrapping: false
            font.bold: true
            color: "white"
            text: "  ✧  "
            opacity: hovered ? 1 : 0
            Layout.preferredWidth: hovered ? implicitWidth : 0
        }

        MaterialIcon {
            text: (UPower.displayDevice.isLaptopBattery || UPower.onBattery) ? getBatteryIcon(Math.round(UPower.displayDevice.percentage * 100)) : "bolt"
            color: "white"
            Layout.alignment: Qt.AlignVCenter || Qt.AlignHCenter
        }
    }
}