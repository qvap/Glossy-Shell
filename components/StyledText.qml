import QtQuick
import QtQuick.Layouts
import qs.config

/* whats 9 + 10 */

Text {
    id: root
    property bool animateChange: false
    property real animationDistanceX: 0
    property real animationDistanceY: 6

    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    wrapMode: Text.WrapAnywhere
    elide: Text.ElideRight
    maximumLineCount: 1
    font {
        hintingPreference: Font.PreferFullHinting
        family: Config.style.fonts.sans
        pixelSize: 18
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 250
            easing.type: Easing.InOutCubic
        }
    }

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: 250
            easing.type: Easing.InOutCubic
        }
    }
}
