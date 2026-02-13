import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.services
import qs.components

HoverableBarWidget {
    id: root

    StyledText {
        id: kbcode
        wrapping: false
        font.bold: true
        color: "white"
        text: HyprlandXkb.currentLayoutCode.toUpperCase()
        font.pixelSize: Config.style.fonts.largeSize - 2.0 // bad practice? idc
        Behavior on text {
            SequentialAnimation {
                NumberAnimation {
                    target: kbcode
                    property: "opacity"
                    to: 0
                    duration: Config.animation.duration.verySmall
                }
                PropertyAction {
                    target: kbcode
                    property: "text"
                }
                NumberAnimation {
                    target: kbcode
                    property: "opacity"
                    to: 1
                    duration: Config.animation.duration.verySmall
                }
            }
        }
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
        id: kbname
        wrapping: false
        font.bold: true
        color: "white"
        text: HyprlandXkb.currentLayoutName
        opacity: root.hovered ? 1 : 0
        Layout.preferredWidth: root.hovered ? implicitWidth : 0
        font.pixelSize: Config.style.fonts.largeSize - 2.0
        Behavior on text {
            SequentialAnimation {
                NumberAnimation {
                    target: kbname
                    property: "opacity"
                    to: 0
                    duration: Config.animation.duration.verySmall
                }
                PropertyAction {
                    target: kbname
                    property: "text"
                }
                NumberAnimation {
                    target: kbname
                    property: "opacity"
                    to: 1
                    duration: Config.animation.duration.verySmall
                }
            }
        }
    }
}
