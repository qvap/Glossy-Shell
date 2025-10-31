import qs.config
import QtQuick

StyledText {
    id: root
    property real discretSize: 0.0

    font.family: Config.style.fonts.icons
    font.pixelSize: Config.style.fonts.veryLargeSize * Config.style.fonts.iconScale + discretSize
    font.variableAxes: ({
            opsz: fontInfo.pixelSize,
            wght: fontInfo.weight
        })
    onTextChanged: {
        anim.start();
    }

    SequentialAnimation {
        id: anim

        BaseAnimation {
            target: root
            property: "opacity"
            from: 0
            to: 1
        }
    }
}
