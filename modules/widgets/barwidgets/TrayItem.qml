import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import qs.config
import qs

MouseArea {
    id: root

    required property SystemTrayItem modelData

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    hoverEnabled: true
    implicitWidth: Config.style.fonts.veryLargeSize
    implicitHeight: Config.style.fonts.veryLargeSize

    onClicked: event => {
        if (event.button === Qt.LeftButton) {
            modelData.activate();
        } else {
            modelData.secondaryActivate();
        }
    }

    onEntered: {
        Global._popOutSeq++;
        const mapped = mapToItem(null, width / 2, 0);
        Global.popOutX = mapped.x;
        Global.popOutY = mapped.y;
        Global.popOutTitle = root.modelData.tooltipTitle || root.modelData.title || root.modelData.id;
        Global.popOutDescription = root.modelData.tooltipDescription || "";
        Global.popOutMenu = root.modelData.hasMenu ? root.modelData.menu : null;
        Global.popOutVisible = true;
    }

    onExited: {
        popOutHideTimer._seq = Global._popOutSeq;
        popOutHideTimer.restart();
    }

    Timer {
        id: popOutHideTimer
        property int _seq: 0
        interval: 300
        onTriggered: {
            if (_seq === Global._popOutSeq)
                Global.popOutVisible = false;
        }
    }

    IconImage {
        id: icon
        anchors {
            fill: parent
        }
        source: root.modelData.icon
    }
}
