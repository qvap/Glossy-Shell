import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.components
import qs.config

/* popout tooltip rendered inside MainWindow with its own Region */

Item {
    id: root

    property bool shown: false
    property real targetX: 0
    property real targetY: 0
    property bool interactive: false
    default property alias contentData: contentContainer.data

    signal entered
    signal exited

    x: targetX - width / 2
    y: targetY - height - Config.style.spacing.small

    visible: opacity > 0
    opacity: 0

    layer.enabled: true
    layer.effect: DropShadow {}

    Behavior on opacity {
        NumberAnimation {
            duration: Config.animation.duration.small
            easing.type: Easing.OutQuart
        }
    }

    Behavior on x {
        enabled: root.visible
        NumberAnimation {
            duration: Config.animation.duration.small
            easing.type: Easing.OutQuart
        }
    }

    // Behavior on y {
    //     enabled: root.visible
    //     NumberAnimation {
    //         duration: Config.animation.duration.small
    //         easing.type: Easing.OutQuart
    //     }
    // }

    // Behavior on width {
    //     enabled: root.visible
    //     NumberAnimation {
    //         duration: Config.animation.duration.small
    //         easing.type: Easing.OutQuart
    //     }
    // }

    Behavior on height {
        enabled: root.visible
        NumberAnimation {
            duration: Config.animation.duration.small
            easing.type: Easing.OutQuart
        }
    }

    onShownChanged: {
        opacity = shown ? 1.0 : 0.0;
    }

    StyledPanelRectangle {
        id: background
        anchors.fill: parent
        radius: Config.style.rounding.small
    }

    HoverHandler {
        enabled: root.interactive
        onHoveredChanged: {
            if (hovered)
                root.entered();
            else
                root.exited();
        }
    }

    ColumnLayout {
        id: contentContainer
        anchors {
            fill: parent
            margins: Config.style.padding.small
        }
        spacing: Config.style.spacing.verySmall
    }
}
