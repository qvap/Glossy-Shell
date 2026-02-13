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

HoverableBarWidget {
    id: root

    property int translatedVolume: Math.round(Audio.defaultSinkVolume * 100)

    readonly property string currentVolumeIcon: {
        if (Audio.defaultSinkMuted)
            return "volume_off";
        if (translatedVolume < 30)
            return "volume_mute";
        if (translatedVolume < 60)
            return "volume_down";
        return "volume_up";
    }

    onTranslatedVolumeChanged: {
        expand();
    }

    MaterialIcon {
        discretSize: -5.0 // stupid misalignment
        text: root.currentVolumeIcon
        color: "white"
        Layout.alignment: Qt.AlignVCenter || Qt.AlignHCenter

        onTextChanged: {
            root.expand();
        }
    }

    StyledText {
        wrapping: false
        font.bold: true
        color: "white"
        text: "  ✧   "
        opacity: root.hovered ? 1 : 0
        Layout.alignment: Qt.AlignVCenter || Qt.AlignHCenter
        Layout.preferredWidth: root.hovered ? implicitWidth : 0
    }

    StyledText {
        wrapping: false
        font.bold: true
        color: "white"
        text: root.translatedVolume
        opacity: root.hovered ? 1 : 0
        Layout.alignment: Qt.AlignVCenter || Qt.AlignHCenter
        Layout.preferredWidth: root.hovered ? implicitWidth : 0
    }
}
