import QtQuick
import QtQuick.Layouts
import qs.config

/* whats 9 + 10 */

Text {
    id: root
    property bool animateChange: false
    property real animationDistanceX: 0
    property real animationDistanceY: 6
    property bool wrapping: true

    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    wrapMode: wrapping ? Text.WrapAnywhere : Text.NoWrap
    elide: wrapping ? Text.ElideRight : Text.ElideNone
    maximumLineCount: wrapping ? 1 : 9999
    font {
        hintingPreference: Font.PreferFullHinting
        family: Config.style.fonts.sans
        pixelSize: Config.style.fonts.largeSize
    }

    Behavior on opacity {
        NumberAnimation {
            duration: Config.animation.duration.small
            easing.type: Easing.OutCirc
        }
    }

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: Config.animation.duration.small
            easing.type: Easing.OutQuart
        }
    }

    layer.enabled: true
    layer.effect: DropShadow {}
}
