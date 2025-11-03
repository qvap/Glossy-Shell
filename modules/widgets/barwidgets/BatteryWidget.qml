import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import qs.config
import qs.services
import qs.components

HoverableBarWidget {
    id: root

    readonly property bool charging: UPower.displayDevice.state === UPowerDeviceState.Charging

    readonly property var batteryIcons: [
        {
            "level": 5,
            "icon": "battery_android_alert"
        },
        {
            "level": 20,
            "icon": "battery_android_frame_1"
        },
        {
            "level": 30,
            "icon": "battery_android_frame_2"
        },
        {
            "level": 40,
            "icon": "battery_android_frame_3"
        },
        {
            "level": 50,
            "icon": "battery_android_frame_4"
        },
        {
            "level": 70,
            "icon": "battery_android_frame_5"
        },
        {
            "level": 90,
            "icon": "battery_android_frame_6"
        },
        {
            "level": 101,
            "icon": "battery_android_frame_full"
        }
    ]

    function getBatteryIcon(percentage) { // should test it
        const index = Math.min(Math.floor(percentage / 15), batteryIcons.length - 1);
        return batteryIcons[Math.max(0, index)].icon;
    }

    onChargingChanged: {
        root.hovered = true;
        startTimer();
    }

    MaterialIcon {
        text: (UPower.displayDevice.isLaptopBattery && !root.charging) ? getBatteryIcon(Math.round(UPower.displayDevice.percentage * 100)) : "water_ec"
        color: "white"
        Layout.alignment: Qt.AlignVCenter || Qt.AlignHCenter
    }

    StyledText {
        wrapping: false
        font.bold: true
        color: "white"
        text: "  ✧  "
        opacity: root.hovered ? 1 : 0
        Layout.preferredWidth: root.hovered ? implicitWidth : 0
    }

    StyledText {
        wrapping: false
        font.bold: true
        color: "white"
        text: (UPower.displayDevice.isLaptopBattery) ? Math.round(UPower.displayDevice.percentage * 100) + "%" : "😝"
        opacity: root.hovered ? 1 : 0
        Layout.preferredWidth: root.hovered ? implicitWidth : 0
    }
}
