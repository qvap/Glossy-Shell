/*CircleProgress {
    anchors {
        centerIn: parent
    }
    value: 0.5

    MaterialIcon {
        anchors {
            centerIn: parent
        }
        text: "volume_up"
    }
}*/
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import qs.config
import qs.services
import qs.components

Item {
    id: root
    property int padding: 10
    property bool showDate: Config.style.barstyle.show_date_in_clock_widget
    implicitWidth: rowLayout.implicitWidth + padding * 2
    implicitHeight: Config.style.barstyle.bar_chunkiness - padding * 2

    property bool hovered: false
    property int translatedVolume: Math.round(Audio.defaultSinkVolume * 100)

    Timer {
        id: hoverTimer
        onTriggered: {
            root.hovered = false;
        }
    }

    readonly property var volumeIcons: [
        {
            "level": 1,
            "icon": "volume_mute"
        },
        {
            "level": 80,
            "icon": "volume_down"
        },
        {
            "level": 100,
            "icon": "volume_up"
        }
    ]

    function getVolumeIcon(percentage) {
        for (const item of volumeIcons) {
            if (percentage < item.level) {
                return item.icon;
            }
        }
        return volumeIcons[volumeIcons.length - 1].icon;
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: {
            startTimer();
        }
    }

    onTranslatedVolumeChanged: {
        root.hovered = true;
        startTimer();
    }

    function startTimer() {
        if (hoverTimer.running) {
            hoverTimer.stop();
        }
        hoverTimer.start();
    }

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 0

        clip: true

        MaterialIcon {
            discretSize: -1.0 // stupid misalignment
            text: Audio.defaultSinkMuted ? "volume_off" : getVolumeIcon(translatedVolume)
            color: "white"
            Layout.alignment: Qt.AlignVCenter || Qt.AlignHCenter

            onTextChanged: {
                root.hovered = true;
                root.startTimer();
            }
        }

        StyledText {
            wrapping: false
            font.bold: true
            color: "white"
            text: "  ✧   "
            opacity: root.hovered ? 1 : 0
            Layout.preferredWidth: root.hovered ? implicitWidth : 0
        }

        StyledText {
            wrapping: false
            font.bold: true
            color: "white"
            text: translatedVolume
            opacity: root.hovered ? 1 : 0
            Layout.preferredWidth: root.hovered ? implicitWidth : 0
        }
    }
}
