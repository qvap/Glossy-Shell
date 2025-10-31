import QtQuick

Loader {
    id: root

    readonly property bool active: opacity > 0

    asynchronous: false
    visible: opacity > 0

    Behavior on opacity {
        BaseAnimation {}
    }

    Behavior on scale {
        BaseAnimation {}
    }
}
