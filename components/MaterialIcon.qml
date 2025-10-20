import qs.config

StyledText {
    font.family: Config.style.fonts.icons
    font.pixelSize: Config.style.fonts.largeSize
    font.variableAxes: ({
        opsz: fontInfo.pixelSize,
        wght: fontInfo.weight
    })
}