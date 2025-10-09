import QtQuick
import QtQuick.Layouts

Text {
    id: root
    property bool animateChange: false
    property real animationDistanceX: 0
    property real animationDistanceY: 6

    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    font {
        hintingPreference: Font.PreferDefaultHinting
        family: "Frutiger"
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
