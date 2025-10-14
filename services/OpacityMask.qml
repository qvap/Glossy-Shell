import Quickshell
import QtQuick

/* and that's yanked from soramane's shell im sowwwwwwwwwwwy */

ShaderEffect {
    required property Item source
    required property Item maskSource

    fragmentShader: Qt.resolvedUrl(`${Quickshell.shellDir}/services/opacitymask.frag.qsb`)
}