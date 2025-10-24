import qs.config

StyledText {
    property real discretSize: 0.0

    font.family: Config.style.fonts.icons
    font.pixelSize: Config.style.fonts.veryLargeSize * Config.style.fonts.iconScale + discretSize
    font.variableAxes: ({
            opsz: fontInfo.pixelSize,
            wght: fontInfo.weight
        })
}
